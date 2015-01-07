class Habit < ActiveRecord::Base
  validates :name, presence: true
  validates :start_date, presence: true
  belongs_to :user
  has_many :events

  def streaks
    if streaks_collection.empty? && !events.empty?
      create_streaks_from_events
    end
    streaks_collection
  end

  def create_streaks_from_events
    events.each do |event|
      if event.completed?
        last_streak.add_event(event)
      else
        add_new_streak
      end
    end
    reject_empty_streaks
  end

  def longest_current_streak_days
    longest_streak = streaks.max_by { |streak| streak.days }
    if longest_streak
      longest_streak.days
    else
      0
    end
  end

  def add_new_streak
    streaks_collection << Streak.new
  end

  def streaks_collection
    @streaks_collection ||= []
  end

  def reject_empty_streaks
    streaks_collection.reject!(&:empty?)
  end

  def last_streak
    if streaks_collection.empty?
      streaks_collection << Streak.new
    end
    streaks_collection.last
  end

  def user_response?
    if self.events.empty? || self.last_24_hours?
      Event.create(completed: false, habit_id: self.id)
    end
  end

  def current_streak_days
    unless streaks.empty? || !events.by_most_recent.first.completed
      streaks.first.days.count
    else
      0
    end
  end

  def sorted_events_for_habit
    events.by_most_recent
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
      last_commit_date = commits.map {|commit| commit['commit']['author']['date'][0..9]}.last
      habit.events.create(completed: true, created_at: last_commit_date)
    end
  end

  def event_requires_update?
    self.events.empty? || self.events.last.created_at.day < Date.yesterday.day
  end

  def create_events(commit_dates)
    commit_dates.each do |date|
      existing_event = self.events.where(created_at: date)
      if !existing_event.empty? && !existing_event.nil?
        existing_event.first.repetitions += 1
        existing_event.first.save
      else
        self.events.create(completed: true, created_at: date)
      end
    end
  end

  def create_false_events(events)
    total = events.count
    counter = 0

    until counter == total - 1 do
      if (events[counter] + 1.day != events[counter + 1])
        self.events.create(completed: false, created_at: events[counter])
      end
      counter += 1
    end
  end

  def last_24_hours?
    self.events.last.created_at < Date.today - 1.day
  end
end
