require 'twilio-ruby'

class TwilioText
  include Webhookable

  def self.send_text(habit_id)
    habit = Habit.find(habit_id)
    user = User.find(habit.user_id)
    user_phone_number = user.phone

    twilio_sid = ENV["TWILIO_SID"]
    twilio_token = ENV["TWILIO_TOKEN"]
    twilio_phone_number = ENV["TWILIO_PHONE_NUMBER"]

    @twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)

    @twilio_client.account.sms.messages.create(
      from: twilio_phone_number,
      to: user_phone_number,
      body: "Did you do your #{habit.name} today? Log it here: www.habitrabbit.org/dashboard"
    )
  end
end
