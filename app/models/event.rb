class Event < ActiveRecord::Base
  belongs_to :habit
  validates :completed, inclusion: { in: [true, false] }

  scope :by_most_recent, -> { order('created_at DESC') }
end
