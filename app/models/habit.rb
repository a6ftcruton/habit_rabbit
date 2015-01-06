class Habit < ActiveRecord::Base
  validates :name, presence: true
  validates :start_date, presence: true
  belongs_to :user
  has_many :events

  def user_response?
    if self.events.empty? || last_24_hours?(self)
      Event.create(completed: false, habit_id: self.id)
    end
  end

  def current_streak_days
    streak = Streak.new
    events = self.events.sort_by {|event| event.created_at}.reverse

    while !events.empty?
      if events[0].completed == true
        streak.increment
      elsif events[0].completed == false
        events = []
      end
      events.shift
    end
    streak.days
  end

  def streaks
    streaks = []
    events = self.events.by_most_recent
    current_streak = nil
    total_events = events.count

    events.each_with_index do |event, index|
      if event.completed
        current_streak ||= Streak.new
        current_streak.increment
        if index == total_events -  1
          streaks << current_streak
        end
      else
        streaks << current_streak if current_streak
        current_streak = nil
      end
    end
    streaks
  end

  def longest_current_streak_days
    longest_streak = streaks.max_by { |streak| streak.days }
    if longest_streak
      longest_streak.days
    else
      0
    end
  end

  def self.notify?
    t = Time.now
    habits = Habit.where(notifications: true).where(notification_time: (t-t.sec-t.min%15*60).strftime("%Y-%m-%d %H:%M:%S"))
    habits.each do |habit|
      TextWorker.perform_async(habit.id)
    end
  end

  def self.github_check
    habits = Habit.where(github_repo: true)
    conn = Faraday.new(:url => 'https://api.github.com') do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end

    habits.each do |habit|
      commits = JSON.parse(conn.get("/repos/#{habit.name}/commits?author=#{habit.user.github_name}").body)
      last_commit_date = commits.map {|commit| commit['commit']['author']['date'].gsub('T',' ')}.last
      habit.events.create(completed: true, created_at: last_commit_date)
    end
  end

  def event_requires_update?(habit)
    habit.events.empty? || habit.events.last.created_at.day < Date.yesterday.day
  end

  private
  def last_24_hours?(habit)
    habit.events.last.created_at < Date.today - 1.day
  end
end
