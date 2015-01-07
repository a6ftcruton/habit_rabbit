class Streak
  attr_reader :events

  def initialize
    @days = []
  end

  def add_event(event)
    @days << event
  end

  def count
    days.count
  end

  def empty?
    count == 0
  end
end
