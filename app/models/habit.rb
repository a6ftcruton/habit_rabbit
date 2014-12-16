class Habit < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :user
  has_many :events

  def streak_days
    # self.events.where(completed: true) # && days in a row
    # I have no idea if this works.
    counter = 0
    day = Date.yesterday
    event = self.events.last
    if !event.nil?
      while event.completed != false do
        event = self.events.where(created_at: (day-1.day)).first
        day = day - 1.day
        counter += 1
      end
    end
    counter
  end
end
