require 'rails_helper'

describe 'user event confirmation', type: :feature do
  include Capybara::DSL

  it 'has confirmation option for each habit' do

  end

  context 'clicking yes' do
    it 'creates a new habit'
    it 'user not re-prompted to confirm during same day'
  end

  context 'clicking no' do
  end

end


