describe 'habit' do

  before do
    @habit = Habit.new
  end

  it 'is valid' do
    @habit.name = "Push ups"
    @habit.save
    expect(@habit).to be_valid
  end

  it 'is invalid with null or blank name' do
    @habit.name = ""
    @habit.save
    expect(@habit).to_not be_valid
  end

  it 'can find its own event streak' do
    @habit.name = "Meditation"
    @habit.save
    5.times do
      @habit.events.create(completed: true)
    end

    @habit.events.last.created_at = "2014-12-17 20:40:46.855146"
    @habit.events.last.save
    @habit.events.fourth.created_at = "2014-12-16 20:40:46.855146"
    @habit.events.fourth.save
    @habit.events.third.created_at = "2014-12-15 20:40:46.855146"
    @habit.events.third.save

    expect(@habit.streak_days).to eq(3)
  end
end
