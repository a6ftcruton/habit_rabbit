class Event < ActiveRecord::Base
  belongs_to :habit
  validates :completed, inclusion: { in: [true, false] } 
#  validates :completed, presence: true
  validates :created_at, presence: true
end
