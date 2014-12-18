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

    it 'can log in using twitter from home page'
  end

  describe 'creating an account' do
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
    visit '/dashboard'
    expect(page).to have_content "Your Habits"
    expect(page).to have_content "Push Ups"
  end

  it 'can create custom streak', js: true do
    skip
    visit '/dashboard'
    expect(page).to have_css('#create-custom')
    click_on('Create Custom Habit')
    expect(page).to have_css('#create-habit-form')
  end

  it 'can receive a tweet', js: true do
    skip
    visit '/dashboard'
    click_on('Create Custom Habit')
    expect(page).to have_css('#manage-habit-form')
  end

end
