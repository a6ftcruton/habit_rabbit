require 'rails_helper'

describe 'authenticated user', type: :feature do
  include Capybara::DSL

  it 'can log in using email from home page' do
    user = User.create(name: 'Aaron',
                       email_address: 'stuff@yomama.com',
                       password: 'password',
                       password_confirmation: 'password'
                       )
    visit root_path
    click_link 'Log in with Email'
    fill_in 'Email', with: 'stuff@yomama.com'
    fill_in 'Password', with: 'Aaron'
    expect(page).to have_content("Welcome, Aaron")
  end

  it 'can create an account using email from home page'

  it 'can log in using twitter from home page'

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
