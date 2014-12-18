class HabitsController < ApplicationController
  before_action :verify_user

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
    user = User.find(current_user.id)
    user.github_name = params[:name]
    user.save
    redirect_to dashboard_path
  end

  def add_notification
    current_user.habits.each do |habit|
      habit.notifications = false
      habit.save
    end
    habits = Habit.find(params[:notification_ids])
    habits.each do |habit|
      habit.notifications = true
      habit.save
    end
    redirect_to dashboard_path
  end

  private

  def verify_user
    redirect_to root_path unless current_user
  end

end
