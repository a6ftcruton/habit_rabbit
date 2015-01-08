require 'twilio-ruby'

class TwilioText
  include Webhookable

  def self.send_text(habit_name, phone)

    twilio_sid = ENV["TWILIO_SID"]
    twilio_token = ENV["TWILIO_TOKEN"]
    twilio_phone_number = ENV["TWILIO_PHONE_NUMBER"]

    @twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)

    @twilio_client.account.sms.messages.create(
      from: twilio_phone_number,
      to: phone,
      body: "Did you do your #{habit_name} today? Log it here: www.habitrabbit.org/dashboard"
    )
  end
end
