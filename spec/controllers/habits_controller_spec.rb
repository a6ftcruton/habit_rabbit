require 'rails_helper'

RSpec.describe HabitsController, :type => :controller do
  describe 'current_user' do
    it 'finds a user when user_id is set' do
      user = create(:user)
      session[:user_id] = user.id
      expect(controller.current_user).to eq(user)
    end

    it 'returns nil when user_id not present' do
      expect(controller.current_user).to eq(nil)
    end

    it 'returns nil when user_id not present' do
      session[:user_id] = 50
      expect(controller.current_user).to eq(nil)
    end

    it 'returns nil when user_id not present' do
      session[:user_id] = 'jim'
      expect(controller.current_user).to eq(nil)
    end
  end
end
