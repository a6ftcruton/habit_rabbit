class Event < ActiveRecord::Base
  belongs_to :habit
  validates :completed, inclusion: { in: [true, false] } 
end
