require 'rails_helper'

describe 'habits', type: :feature do
  include Capybara::DSL

  before do
    @user = create(:user)
    @user.habits.create(name: 'pushups', start_date: Time.now)
    page.set_rack_session(user_id: @user.id)
    visit dashboard_path
  end

  it 'can delete a habit' do
    expect(page).to have_content('pushups')
    click_link 'Delete Habit'
    expect(page).to_not have_content('pushups')
  end

  it 'can edit a habit' do
    click_link 'More Information'
    fill_in 'habit_name', with: 'Pushups'
    click_link_or_button 'Save'
    expect(page).to have_content('Pushups')
  end

  it 'can go to a show page for the habit' do
    click_link 'More Information'
    expect(page).to have_content('pushups habit')
  end

  it 'saves habits for the user' do
    expect(page).to have_content 'pushups'
    visit signout_path
    expect(current_path).to eq root_path
    sign_in_with_twitter
    expect(page).to have_content 'pushups'
  end

  it 'can tweet a habit' do
    expect(page).to have_content('pushups')
    click_link 'More Information'
    expect(page).to have_content('Tweet My Streak')
  end

end
