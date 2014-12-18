require 'rails_helper'

describe 'habits', type: :feature do
  include Capybara::DSL

  before do
    @user = User.create(name: "Joe", email_address: "stuff@whatup.com", password: 'password', password_confirmation: 'password')
    @user.habits.create(name: 'pushups')
    page.set_rack_session(user_id: @user.id)
    visit dashboard_path
  end

  it 'can delete a habit' do
    expect(page).to have_content('pushups')
    click_link 'Delete Habit'
    expect(page).to_not have_content('pushups')
  end

  it 'can edit a habit' do
    click_link 'Edit Habit'
    fill_in 'habit_name', with: 'Pushups'
    click_link_or_button 'Save'
    expect(page).to have_content('Pushups')
  end

  it 'can go to a show page for the habit' do
    click_link 'More Information'
    expect(page).to have_content('Super Details about your habitual habits')
  end
end
