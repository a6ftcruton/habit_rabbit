require 'rails_helper'

describe 'authenticated user', type: :feature do
  include Capybara::DSL

  it 'visits dashboard' do
    visit '/dashboard'
    expect(page).to have_content "Welcome"
  end

  it 'displays all habits' do
    visit '/dashboard'
    expect(page).to have_content "Your Habits"
    expect(page).to have_content "Push Ups"
  end

  it 'can create custom streak', js: true do
    visit '/dashboard'
    expect(page).to have_css('#create-custom')
    click_on('Create Custom Habit')
    expect(page).to have_css('#create-habit-form')
  end

end
