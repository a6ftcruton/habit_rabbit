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
end
