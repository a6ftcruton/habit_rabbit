require 'rails_helper'

describe 'authenticated user', type: :feature do
  include Capybara::DSL

  describe 'logging in' do
    it 'can log in using email from home page' do
      user = User.create(name: 'Aaron',
                         email_address: 'stuff@yomama.com',
                         password: 'password',
                         password_confirmation: 'password'
                         )
      visit root_path
      click_link 'Log in with Email'
      fill_in 'user_email_address', with: 'stuff@yomama.com'
      fill_in 'user_password', with: 'password'
      click_link_or_button 'Login'
      expect(page).to have_content("Welcome, Aaron")
    end
  end

  describe 'creating an account with email' do
    it 'can create an account using email from home page' do
      visit root_path
      click_link "Create Account with Email"
      fill_in 'user_name', with: 'Aaron'
      fill_in 'user_email_address', with: 'jokes@laugh.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_link_or_button 'Create My Account'
      # save_and_open_page
      expect(page).to have_content("Welcome, Aaron")
    end
  end

  it 'displays all habits' do
    skip
  before do
    sign_in_with_twitter
    @habit = create(:habit)
  end

  it 'can visit dashboard' do
    visit '/dashboard'
    expect(page).to have_content "Welcome, Yukon Cornelius"
  end
  # Habits:
  # ==================================
  it 'can create a new habit', js: true do
    visit '/dashboard'
    expect(page).to_not have_content 'push ups'
    click_on('Create Custom Habit')
    page.fill_in('Habit', with: 'push ups')
    click_on('Create Habit')
    expect(page).to have_content 'Your Habit was saved successfully.'
  end
  #
  # it 'can receive a tweet', js: true do
  #   visit '/dashboard'
  #   click_on('Create Custom Habit')
  #   expect(page).to have_css('#manage-habit-form')
  # end

  it 'can receive a tweet', js: true do
    skip
    visit '/dashboard'
    click_on('Create Custom Habit')
    expect(page).to have_css('#manage-habit-form')
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
