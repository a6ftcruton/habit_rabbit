class Event < ActiveRecord::Base
  belongs_to :habit
  validates :completed, presence: true
  validates :created_at, presence: true

  def user_response?(habit)
      if last_24_hours?(habit)
        Event.create(completed: false, habit_id: habit.id)
      end
    end
  end

  private
  def last_24_hours?(habit)
    habit.events.last.created_at > 24.hours.ago
  end
end
