class EventsController < ApplicationController
  def create
    @habit = Habit.find(params["event"]["habit_id"])
    @event = Event.new(event_params.merge(habit_id: @habit.id))
    if @event.save
      flash[:notice] = "Thanks! We've updated your streak."
      redirect_to '/dashboard'
    else
      flash[:error] = "We weren't able to save your habit. Try again later."
      render :back
    end
  end

  private

  def event_params
    params.require(:event).permit(:completed, :repetitions, :created_at, :updated_at )
  end
end
