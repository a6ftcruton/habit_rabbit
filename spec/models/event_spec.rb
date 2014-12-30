require 'rails_helper'

describe 'event' do

  before do
    @user = create(:user)
    @habit = create(:habit)
    @habit.user_id = @user.id
    @event = Event.new(completed: true, habit_id: @habit.id)
  end

  # it 'is valid' do
  #   expect(@event).to be_valid
  # end
  #
  # it 'is invalid when "completed" column not boolean value' do
  #   @event.completed = ""
  #   expect(event).to_not be_valid
  # end
  #
  # it 'is invalid without a date' do
  #   @event.created_at = ""
  #   expect(@event).to_not be_valid
  # end

  it 'creates an event if user has not responded in 24 hours' do
    # @event = Event.create(completed: true, habit_id: @habit.id)
    event2 = @event.dup
    event2.created_at = 48.hours.ago
    expect(Event.count).to eq(2)

    @user.habits.each do |habit|
      user_response?(habit)
    end
    
    expect(Event.count).to eq(3)
  end
end
