require 'rails_helper'

describe 'habits', type: :feature do
  include Capybara::DSL

  before do
    @user = create(:user)
    @habit = create(:habit, user_id: @user.id)
    page.set_rack_session(user_id: @user.id)
    visit dashboard_path
  end

  it 'can delete a habit' do
    visit habit_path(@habit)
    expect(page).to have_content(@habit.name)
    click_on 'Delete Habit'
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
    expect(page).to have_content("#{@habit.name} habit")
  end

  it 'saves habits for the user' do
    expect(page).to have_content @habit.name
    visit signout_path
    expect(current_path).to eq root_path
    sign_in_with_twitter
    expect(page).to have_content @habit.name
  end

  it 'can tweet a habit' do
    expect(page).to have_content(@habit.name)
    expect(page).to have_content('Tweet My Streak')
  end
end
