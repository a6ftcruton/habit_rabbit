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
    it 'return zero if no events' do
      expect(@habit.current_streak_days).to eq(0)
    end

    it 'returns zero if most recent event is false' do
      @habit.events.create(completed: true, created_at: '2015-01-02 19:49:16Z')
      @habit.events.create(completed: false, created_at: '2015-01-05 19:49:16Z')
      expect(@habit.current_streak_days).to eq(0)
    end
  end

  describe '#create_events' do
    it 'can create events based on dates passed in' do
      dates = ['2015-01-01 19:49:16Z', '2015-01-02 19:49:16Z', '2015-01-04 19:49:16Z', '2015-01-05 19:49:16Z', '2015-01-06 19:49:16Z']
      @habit.create_events(dates)

      expect(@habit.events.size).to eq(5)
    end
  end

  describe '#create_false_events' do
    it 'can create events set to completed false based on events passed in' do
      dates = ['2015-01-01 19:49:16Z', '2015-01-02 19:49:16Z', '2015-01-04 19:49:16Z', '2015-01-06 19:49:16Z', '2015-01-08 19:49:16Z']
      @habit.create_events(dates)
      events = @habit.events.map {|d| d.created_at.to_date }.uniq
      @habit.create_false_events(events)

      expect(@habit.events.size).to eq(8)
    end
  end

  def build_streak(length)
    length.times do
      @habit.events.create(completed: true)
    end
  end
end
