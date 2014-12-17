class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :ensure_user


  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def ensure_user
    redirect_to root_url if current_user.nil?
  end

end
