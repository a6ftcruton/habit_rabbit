require 'rails_helper'

describe 'event' do

  before do
    @habit = create(:habit)
  end

  it 'is valid' do
    event = create(:event)
    expect(event).to be_valid
  end

  it 'is invalid when "completed" column not boolean value' do
    event = create(:event)
    event.completed = ""
    expect(event).to_not be_valid
  end

end
