require 'rails_helper'

describe 'event' do
  before do
    @user = create(:user)
    @habit = create(:habit, user_id: @user.id)
    @event = create(:event, habit_id: @habit.id, created_at: 1.hour.ago, completed: true)
  end

  it 'is valid' do
    expect(@event).to be_valid
  end

  it 'is invalid when "completed" column not boolean value' do
    @event.completed = ""
    expect(@event).to_not be_valid
  end

  it 'creates an event if user has not responded in 24 hours' do
    second_event = Event.create(completed: true, habit_id: @habit.id, created_at: Time.now - 48.hours)
    expect(Event.count).to eq(2)

    @user.habits.first.user_response?

    expect(Event.count).to eq(3)
  end

  it 'creates an event after 24 hours if there were no pre-existing event' do
    habit = create(:habit)
    habit.user_response?
    expect(habit.events.count).to eq(1)
  end
end
