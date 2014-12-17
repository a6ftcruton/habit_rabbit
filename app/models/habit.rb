class Habit < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :user
  has_many :events

  def streak_days
    # self.events.where(completed: true) # && days in a row
    # I have no idea if this works.  Thinking we might need to get more specific with
    # the date (we need to see if there was a completed event at any point during the day)
    counter = 0
    day = Date.yesterday.strftime("%d %b. %Y")
    events = self.events
    if !events.nil?
      while event.completed != false do
        event = self.events.where(created_at: (day-1.day)).first
        day = day - 1.day
        counter += 1
        puts counter
      end
    end
    counter
  end
end
