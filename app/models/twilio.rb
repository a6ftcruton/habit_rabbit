require 'twilio-ruby'

class Twilio < ActiveRecord::Base
  include Webhookable
  after_filter :set_header
  skip_before_action :verify_authenticity_token

  def send_text(user)
    user_phone_number = user.phone_number

    twilio_sid = ENV["TWILIO_SID"]
    twilio_token = ENV["TWILIO_TOKEN"]
    twilio_phone_number = ENV["TWILIO_PHONE_NUMBER"]

    @twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)

    @twilio_client.account.sms.messages.create(
    from: twilio_phone_number,
    to: twilio_phone_number,
    #to: user_phone_number,
    body: "We are now tracking your #{habit}!"
    )

    redirect_to dashboard_path
  end
end
