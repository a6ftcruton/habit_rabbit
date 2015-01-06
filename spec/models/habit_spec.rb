require 'rails_helper'

describe 'habit' do

  before do
    @habit = create(:habit)
  end

  it 'is valid' do
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
    build_streak(1)
    @habit.events.create(completed: false)

    build_streak(2)

    expect(@habit.current_streak_days).to eq(2)
  end

  it 'returns an array of streak objects' do
    @habit.events.create(completed: true)
    build_streak(5)

    @habit.events.create(completed: false)

    build_streak(2)

    expect(@habit.current_streak_days).to eq(2)
    expect(@habit.streaks.size).to eq(2)
  end

  it 'finds longest streak' do
    build_streak(5)
    @habit.events.create(completed: false)
    build_streak(2)

    expect(@habit.longest_current_streak_days).to eq(5)
  end

  describe '#longest_current_streak_days' do
    it 'returns zero if no events' do
      expect(@habit.longest_current_streak_days).to eq(0)
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
      @habit.events.create(completed: true)
      @habit.events.create(completed: false)
      expect(@habit.current_streak_days).to eq(0)
    end
  end

  def build_streak(length)
    length.times do
      @habit.events.create(completed: true)
    end
  end
end
