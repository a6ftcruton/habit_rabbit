require 'rails_helper'
describe 'streaks' do
  it 'adds one each time increment is called' do
    streak = Streak.new
    expect(streak.days).to eq(0)
    streak.increment
    expect(streak.days).to eq(1)
  end

  
end
