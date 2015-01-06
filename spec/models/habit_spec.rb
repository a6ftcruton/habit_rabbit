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

    expect(@habit.current_streak_days).to eq(2)
  end

  it 'returns an array of streak objects' do
    @habit.name = "Running"
    @habit.start_date = Time.now
    @habit.save

    @habit.events.create(completed: true)

    5.times do
      @habit.events.create(completed: true)
    end

    3.times do
      @habit.events.create(completed: false)
    end

    2.times do
      @habit.events.create(completed: true)
    end
    expect(@habit.current_streak_days).to eq(2)
    expect(@habit.streaks.size).to eq(2)
  end

  it 'finds longest streak' do
    @habit.name = "Running"
    @habit.start_date = Time.now
    @habit.save

    5.times do
      @habit.events.create(completed: true)
    end

    3.times do
      @habit.events.create(completed: false)
    end

    2.times do
      @habit.events.create(completed: true)
    end

    expect(@habit.longest_streak_days).to eq(5)
  end

  describe '#longest_streak_days' do
    it 'returns zero if no events' do
      expect(@habit.longest_streak_days).to eq(0)
    end
  end

  describe '#streaks' do
    it 'returns an empty array if no events' do
      expect(@habit.streaks).to eq([])
    end
  end

  describe '#current_streak_days' do
    it 'return zero of no events' do
      expect(@habit.current_streak_days).to eq(0)
    end

    it 'returns zero if most recent event is false' do
      @habit.name = "Running"
      @habit.start_date = Time.now
      @habit.save
      @habit.events.create(completed: true)
      @habit.events.create(completed: false)
      expect(@habit.current_streak_days).to eq(0)
    end
  end
end
