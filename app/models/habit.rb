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

  private
  def last_24_hours?(habit)
    habit.events.last.created_at < Date.today - 1.day
  end
end
