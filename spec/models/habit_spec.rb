require 'rails_helper'

describe 'habit' do

  before do
    @habit = Habit.new
  end

  it 'is valid' do
    @habit.name = "Push ups"
    @habit.start_date = Time.now
    @habit.save
    expect(@habit).to be_valid
  end

  it 'is invalid with null or blank name' do
    @habit.name = ""
    @habit.save
    expect(@habit).to_not be_valid
  end

  it 'is invalid without a start date' do
    @habit.start_date = ""
    expect(@habit).to_not be_valid
  end

  it 'can find its own event streak' do
    @habit.name = "Meditation"
    @habit.start_date = Time.now
    @habit.save

    @habit.events.create(completed: true)

    3.times do
      @habit.events.create(completed: false)
    end

    2.times do
      @habit.events.create(completed: true)
    end

    expect(@habit.streak_days).to eq(2)
  end
end
