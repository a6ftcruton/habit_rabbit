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

  def streak_days
    counter = 0
    events = self.events.sort_by {|event| event.created_at}.reverse

    while !events.empty?
      if events[0].completed == true
        counter += 1
      elsif events[0].completed == false
        events = []
      end
      events.shift
    end
    counter
  end

  def self.notify?
    t = Time.now
    habits = Habit.where(notifications: true).where(notification_time: (t-t.sec-t.min%15*60).strftime("%Y-%m-%d %H:%M:%S"))
    habits.each do |habit|
      TextWorker.perform_async(habit.id)
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
