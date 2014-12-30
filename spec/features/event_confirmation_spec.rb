require 'rails_helper'

describe 'user event confirmation', type: :feature do
  include Capybara::DSL

  before do
    sign_in_with_twitter
    @habit = create(:habit)
  end

  it 'has confirmation option for each habit' do
    visit '/habits/1' 
    expect(page).to have_content @habit.name
    within('.confirm-event') do
      click_on 'YES'
    end
    expect(current_path).to eq '/habits/1'
    expect(page).to have_content "Thanks! We've updated your streak."      
  end

  context 'clicking yes' do
    it 'creates a new habit'
    it 'user not re-prompted to confirm during same day'
  end

  context 'clicking no' do
  end

end


