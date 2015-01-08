require 'rails_helper'

describe 'user event confirmation', type: :feature do
  include Capybara::DSL

  before do
    @user = create(:user)
    page.set_rack_session(user_id: @user.id)
    @habit = create(:habit, user_id: @user.id)
  end

  it 'has confirmation option for each habit' do
    visit '/dashboard'
    expect(page).to have_content @habit.name
    click_on 'YES'
    expect(current_path).to eq dashboard_path
    expect(page).to have_content "Thanks! We've updated your streak."
  end

  describe 'clicking yes' do
    it 'creates a new habit' do
      events = Habit.last.events.count
      visit '/dashboard'
      expect(current_path).to eq dashboard_path
      click_link_or_button 'YES'
      updated_events = Habit.last.events.count
      expect(updated_events).to eq (events + 1)
    end
  end
end
