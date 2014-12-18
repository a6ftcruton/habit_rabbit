class TextWorker
  include Sidekiq::Worker
  def perform(habit_id)
    TwilioText.send_text(habit_id)
  end
end
