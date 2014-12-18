class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to dashboard_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def login
    user = User.find_by(email_address: params[:email_address])
    if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect_to dashboard_path
  end
end
