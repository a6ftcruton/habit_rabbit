class Habit < ActiveRecord::Base
  validates :name, presence: true
  validates :start_date, presence: true
  belongs_to :user
  has_many :events

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

  def event_requires_update?(habit)
    habit.events.empty? || habit.events.last.created_at.day < Date.yesterday.day
  end
end
