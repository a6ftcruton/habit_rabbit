class HabitsController < ApplicationController
  before_action :verify_user

  def index
    @habit = Habit.new
  end

  def new
  end

  def create
    respond_to do |format|
      @habit = Habit.create(name: params[:name], user_id: current_user.id)
      if @habit.save!
        format.js {@habit}
      else
        flash[:notice] = "Your habit must have a name"
        render :back
      end
    end
  end

  def show
  end

  private
  def verify_user
    redirect_to root_path unless current_user
  end
end
