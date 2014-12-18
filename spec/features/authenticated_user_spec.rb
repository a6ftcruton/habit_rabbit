require 'rails_helper'

describe 'authenticated user', type: :feature do
  include Capybara::DSL

  before do
    sign_in_with_twitter
    @habit = create(:habit)
  end

  it 'can visit dashboard' do
    visit '/dashboard'
    expect(page).to have_content "Welcome Yukon Cornelius"
  end

  # Habits:
  # ==================================
  it 'can create a new habit', js: true do
    visit '/dashboard'
    expect(page).to_not have_content 'push ups'
    click_on('Create Custom Habit')
    page.fill_in('Name', with: 'push ups')
    click_on('Create')
    expect(page).to have_content 'Your Habit was saved successfully.'
  end

  it 'can view habit details'
  it 'can edit a habit' 
  it 'can delete a habit'
  it 'can add notification to a habit'

  # Notifications:
  # ==================================
  it 'can edit notifications'
  it 'can stop notification'
  
end
