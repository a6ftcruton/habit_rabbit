class HabitsController < ApplicationController

  def index
    @habit = Habit.new
    if !current_user.github_name.nil? && !current_user.github_name.empty?
      @github_user = Octokit.user(current_user.github_name)
    end
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

  def add_github
    respond_to do |format|
      user = User.find(current_user.id)
      puts user
      user.github_name = params[:name]
      user.save
    end
  end
end
