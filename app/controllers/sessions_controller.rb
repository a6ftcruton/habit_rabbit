class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env['omniauth.auth'])
    Rails.logger.info("we here")
    session[:user_id] = user.id
    redirect_to dashboard_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
