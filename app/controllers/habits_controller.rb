class HabitsController < ApplicationController
  before_action :verify_user
  before_filter :check_ownership, only: [:show]
  before_action :verify_phone_number

  def index
    @habits = current_user.habits.all
  end

  def create
    if params[:title].empty?
      flash[:error] = "Your habit must have a name"
      redirect_to dashboard_path
    else
      Habit.create(name: params[:title], user_id: current_user.id, start_date: params[:start_date])
      flash[:notice] = "Your Habit was saved successfully"
      redirect_to dashboard_path
    end
  end

  def show
    @user = current_user
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
    conn = new_faraday_connection
    test_connection = conn.get("/repos/#{params[:repo]}/commits?author=#{current_user.github_name}&per_page=100000")

    if current_user.github_name.nil?
      flash[:error] = "You must first enter your Github Name on the Settings Page."
      redirect_to user_path(current_user)
    elsif test_connection.status != 200
      flash[:error] = "Invalid github repo"
      redirect_to dashboard_path
    elsif params[:repo].empty?
      flash[:error] = "You must enter a repo"
      redirect_to dashboard_path
    else
      flash[:notice] = "Your Repo is being tracked"
      create_github_habit(params)

      redirect_to dashboard_path
    end
  end

  private

  def verify_user
    redirect_to root_path unless current_user
  end

  def check_ownership
    @habit = Habit.find(params[:id])
    redirect_to dashboard_path unless @habit.user == current_user
  end

  def verify_phone_number
    if !current_user.phone || current_user.phone.empty?
      flash[:error] = "Please Update Your Information"
      redirect_to user_path(current_user)
    end
  end

  def create_github_habit(params)
    @habit = Habit.create(name: params[:repo], user_id: current_user.id, start_date: params[:start_date], github_repo: true)
    commit_dates = get_commit_dates(params).sort
    @habit.create_events(commit_dates)
    events = @habit.events.map {|d| d.created_at.to_date }.uniq.sort
    @habit.create_false_events(events)
  end

  def get_datetime(params)
    time = Time.new(params["habit"]["notification_time(1i)"].to_i,
             params["habit"]["notification_time(2i)"].to_i,
             params["habit"]["notification_time(3i)"].to_i,
             params["habit"]["notification_time(4i)"].to_i,
             params["habit"]["notification_time(5i)"].to_i).utc

    (time - 27.hours).strftime("%Y-%m-%d %H:%M:%S")
  end

  def get_commit_dates(params)
    conn = new_faraday_connection
    commits = JSON.parse(conn.get("/repos/#{params[:repo]}/commits?author=#{current_user.github_name}&per_page=100000").body)
    commits.map {|commit| commit['commit']['author']['date'][0..9]}.reverse
  end

  def new_faraday_connection
    Faraday.new(:url => 'https://api.github.com') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end
end
