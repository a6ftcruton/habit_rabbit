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
        render :create
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
    @habit.update(notifications: params[:habit][:notifications], name: params[:habit][:name], notification_time: datetime)
    if @habit.save
      redirect_to dashboard_path
    else
      flash.now[:notice] = "Please try again. Your habit " + @habit.errors.full_messages.first 
      render :show
    end
  end

  def destroy
    @habit = Habit.find(params[:id])
    @habit.destroy
    redirect_to dashboard_path
  end

  def track_repo
    #move almost all of this shit out of the controller, for realsies.
    respond_to do |format|
      conn = Faraday.new(:url => 'https://api.github.com') do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end

      @habit = Habit.create(name: params[:repo], user_id: current_user.id, start_date: params[:start_date], github_repo: true)
      if @habit.save!
        flash[:notice] = "Your Repo is being tracked"
        #create events with dates
        @commits = JSON.parse(conn.get("/repos/#{params[:repo]}/commits?author=#{current_user.github_name}").body)
        @commit_dates = @commits.map {|commit| commit['commit']['author']['date'].gsub('T',' ')}

        @commit_dates.each do |date|
          @habit.events.create(completed: true, created_at: date)
        end

        format.js {@habit}
      else
        flash[:notice] = "You must enter a repo"
        render :back
      end
    end
  end

  private

  def verify_user
    redirect_to root_path unless current_user
  end

end
