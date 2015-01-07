class HabitsController < ApplicationController
  before_action :verify_user

  def index
    @habits = current_user.habits.all
  end

  def create
    respond_to do |format|
      @habit = Habit.create(name: params[:title], user_id: current_user.id, start_date: params[:start_date])
      if @habit.save
        flash[:notice] = "Your Habit was saved successfully"
        format.js {@habit}
      else
        flash[:notice] = "Your habit must have a name"
        render :create
      end
    end
  end

  def show
    @habit = Habit.find(params[:id])
    @events = @habit.events.pluck(:created_at, :completed)
    @events = @events.each do |event|
      event[0] = event[0].to_i
      event[1] == true ? event[1] = 1 : event[1] = 0
    end.to_json.html_safe
  end

  def update
    datetime = get_datetime(params)

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
    if current_user.github_name.nil?
      flash[:error] = "You must first enter your Github Name on the Settings Page."
      redirect_to user_path(current_user)
    elsif params[:repo].empty?
      flash[:error] = "You must enter a repo"
      redirect_to dashboard_path
    else
      flash[:notice] = "Your Repo is being tracked"
      @habit = Habit.create(name: params[:repo], user_id: current_user.id, start_date: params[:start_date], github_repo: true)
      commit_dates = get_commit_dates(params)
      @habit.create_events(commit_dates)
      events = @habit.events.map {|d| d.created_at.to_date }.uniq
      @habit.create_false_events(events)

      redirect_to dashboard_path
    end
  end

  private

  def verify_user
    redirect_to root_path unless current_user
  end

  def get_datetime(params)
    Time.new(params["habit"]["notification_time(1i)"].to_i,
             params["habit"]["notification_time(2i)"].to_i,
             params["habit"]["notification_time(3i)"].to_i,
             params["habit"]["notification_time(4i)"].to_i,
             params["habit"]["notification_time(5i)"].to_i).strftime("%Y-%m-%d %H:%M:%S")
  end

  def get_commit_dates(params)
    conn = Faraday.new(:url => 'https://api.github.com') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
    commits = JSON.parse(conn.get("/repos/#{params[:repo]}/commits?author=#{current_user.github_name}&per_page=100000").body)
    commits.map {|commit| commit['commit']['author']['date'][0..9]}.reverse
  end

end
