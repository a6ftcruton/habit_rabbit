class Habit < ActiveRecord::Base
  validates :name, presence: true
  validates :start_date, presence: true
  belongs_to :user
  has_many :events

  def user_response?
    if last_24_hours?(self)
      Event.create!(completed: false, habit_id: self.id, created_at: Time.now)
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
    habits = Habit.where(notifications: true)
    habits.each do |habit|
      TextWorker.perform_async(habit.id)
    end
  end

  private
  def last_24_hours?(habit)
    habit.events.last.created_at < Date.today - 1.day
  end
end
