class HabitsController < ApplicationController
  before_action :verify_user

  def index
    @habits = current_user.habits.all
    @habit = Habit.new
    @event = Event.new
  end

  def new
  end

  def create
    respond_to do |format|
      @habit = Habit.create(name: params[:title], user_id: current_user.id, start_date: params[:start_date])
      if @habit.save!
        flash[:notice] = "Your Habit was saved successfully"
        # TextNotification.send_text(current_user)
        format.js {@habit}
      else
        flash[:notice] = "Your habit must have a name"
        render :back
      end
    end
  end

  def show
    @habit = Habit.find(params[:id])
  end

  def update
    datetime = Time.new(params["habit"]["notification_time(1i)"].to_i, params["habit"]["notification_time(2i)"].to_i,
    params["habit"]["notification_time(3i)"].to_i, params["habit"]["notification_time(4i)"].to_i,
    params["habit"]["notification_time(5i)"].to_i).strftime("%Y-%m-%d %H:%M:%S")
    @habit = Habit.find(params[:id])
    @habit.update(name: params[:habit][:name], notification_time: datetime)
    if @habit.save
      redirect_to dashboard_path
    else
      flash[:notice] = "Please Try again"
      redirect_to :back
    end
  end

  def destroy
    @habit = Habit.find(params[:id])
    @habit.destroy
    redirect_to dashboard_path
  end

  def update_notifications
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

  private

  def verify_user
    redirect_to root_path unless current_user
  end

end
