class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
  end

  def create
    user = User.create(user_params)
    if user.valid?
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      redirect_to root_path
    end
  end

  def update
    current_user.update(phone: params[:phone])
    redirect_to '/dashboard'
  end

  def add_github
    user = User.find(current_user.id)
    user.github_name = params[:name]
    user.save
    redirect_to dashboard_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
  end
end
