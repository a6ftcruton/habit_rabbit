class HabitsController < ApplicationController

  def index
    @habit = Habit.new
    @github_user = Octokit.user(current_user.github_name)
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
end
