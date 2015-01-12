require 'rails_helper'

describe 'authenticated user', type: :feature do
  include Capybara::DSL

  before do
    sign_in_with_twitter
    page.fill_in('phone', with: '5014993998')
    click_link_or_button 'Create'
  end

  it 'can visit dashboard', js: true do
    visit '/dashboard'
    expect(page).to have_content user_welcome_message 
  end

  it 'can log out' do
    visit '/dashboard'
    click_on('Log Out')
    expect(page).to_not have_content user_welcome_message 
    expect(page).to have_content "Log in with Twitter"
  end

  it 'can create a new habit', js: true do
    create_habit("push ups")
    expect(page).to have_content 'push ups'
  end

  it 'cannot create a habit without a name', js: true do
    create_habit('')
    expect(page).to have_content "Your habit must have a name"
  end

  it 'can add notification to a habit', js: true do
    Habit.destroy_all
    user = User.first
    create_habit("push ups")
    expect(page).to have_content('push ups')
    expect(user.habits.first.notifications).to be_falsey
    within('.habit_content') { click_on "More Information" }
    page.find('#habit_notifications').click
    click_on "Save"
    expect(current_path).to eq dashboard_path
    expect(user.habits.first.notifications).to be_truthy
  end

  private

  def create_habit(habit_name)
    visit '/dashboard'
    expect(page).to_not have_content 'push ups'
    click_on('Create Custom Habit')
    page.fill_in('Habit', with: habit_name)
    click_on('Create Habit')
  end

  def user_welcome_message 
    "Welcome, Yukon Cornelius"
  end
end
