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

  def signin
    @user = User.new
  end

  def login
    user = User.find_by(email_address: params[:user][:email_address])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      redirect_to root_path
    end
  end
end
