require 'rails_helper'

describe 'streaks' do
  it 'adds one each time increment is called' do
    event = create(:event)
    streak = Streak.new
    expect(streak.count).to eq(0)
    streak.add_event(event)
    expect(streak.count).to eq(1)
  end
end
