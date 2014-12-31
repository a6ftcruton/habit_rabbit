class EventsController < ApplicationController
  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = "Thanks! We've updated your streak."
      redirect_to '/dashboard'
    else
      flash[:error] = "We weren't able to save your habit. Try again later."
      redirect_to '/dashboard'
    end
  end

  private

  def event_params
    params.require(:event).permit(:habit_id, :completed, :repetitions, :created_at, :updated_at )
  end
end
