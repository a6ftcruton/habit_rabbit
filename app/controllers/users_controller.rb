class UsersController < ApplicationController

  def update
    current_user.phone = params[:phone]
    current_user.save
    redirect_to '/dashboard'
  end

end
