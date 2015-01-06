class Streak
  attr_accessor :days

  def initialize
    @days = 0
  end

  def increment
    @days += 1
  end
end
