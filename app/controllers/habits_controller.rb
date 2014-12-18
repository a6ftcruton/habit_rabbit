class HabitsController < ApplicationController
  before_action :verify_user

  def index
    # raise HELL
    @habit = Habit.new
    if !current_user.github_name.nil? && !current_user.github_name.empty?
      @github_user = Octokit.user(current_user.github_name)
    end
  end

  def new
  end

  def create
    respond_to do |format|
      @habit = Habit.create(name: params[:title], user_id: current_user.id)
      if @habit.save!
        # TextNotification.send_text(current_user)
        format.js {@habit}


        # send text. "congrats, good luck"


      else
        flash[:notice] = "Your habit must have a name"
        render :back
      end
    end
  end

  def show
  end

  def update
    respond_to do |format|
      current_user.habits.each do |habit|
        habit.notifications = false
        habit.save
      end
      habits = Habit.find(params[:notification_ids])
      habits.each do |habit|
        habit.notifications = true
        habit.save
      end

      format.js {}
    end
  end

  def add_github
    user = User.find(current_user.id)
    user.github_name = params[:name]
    user.save
    redirect_to dashboard_path
  end

  private

  def verify_user
    redirect_to root_path unless current_user
  end

end
