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
      @habit = Habit.create(name: params[:title], user_id: current_user.id)
      if @habit.save!
        TextNotification.send_text(current_user)
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


require 'twilio-ruby'

class TextNotification
  include Webhookable
  # after_filter :set_header
  # skip_before_action :verify_authenticity_token

  def self.send_text(user)
    user_phone_number = user.phone

    twilio_sid = ENV["TWILIO_SID"]
    twilio_token = ENV["TWILIO_TOKEN"]
    twilio_phone_number = ENV["TWILIO_PHONE_NUMBER"]

    @twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)

    @twilio_client.account.sms.messages.create(
    from: twilio_phone_number,
    to: user_phone_number,
    body: "We are now tracking your habit!"
    )

    redirect_to dashboard_path
  end
end
