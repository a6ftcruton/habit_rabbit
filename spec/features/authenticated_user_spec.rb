describe 'authenticated user', type: :feature do
  include Capybara::DSL

  before do
    sign_in_with_twitter
  end

  it 'displays all habits' do
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
  it 'can add notification to a habit' do

    # visit '/dashboard'
    # click_on()
  end

  # Notifications:
  # ==================================
  it 'can edit notifications'
  it 'can stop notification'
end
