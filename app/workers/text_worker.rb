class TextWorker
  include Sidekiq::Worker
  def perform(habit_name, phone)
    TwilioText.send_text(habit_name, phone)
  end
end
