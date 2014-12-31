require 'rails_helper'

describe 'user event confirmation', type: :feature do
  include Capybara::DSL

  before do
    @user = User.create(name: "Joe", email_address: "stuff@whatup.com", password: 'password', password_confirmation: 'password')
    page.set_rack_session(user_id: @user.id)
    @habit = Habit.create!(user_id: @user.id, name: "pushups", start_date: Time.now)
  end

  it 'has confirmation option for each habit' do
    visit '/dashboard' 
    expect(page).to have_content @habit.name
    click_on 'YES'
    expect(current_path).to eq dashboard_path 
    expect(page).to have_content "Thanks! We've updated your streak."      
  end

  context 'clicking yes or no' do

    it 'creates a new habit' do
      events = Habit.last.events.count
      visit '/dashboard' 
      click_on 'NO'
      expect(current_path).to eq dashboard_path 
      updated_events = Habit.last.events.count
      expect(updated_events).to eq (events + 1)
    end

    it 'user not re-prompted to confirm during same day' do
      visit '/dashboard'
      expect(page).to have_css('.event-form')
      click_on 'YES'
      expect(current_path).to eq dashboard_path 
      expect(page).to_not have_css('.event-form')
    end
  end

end


