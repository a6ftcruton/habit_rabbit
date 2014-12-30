class EventsController < ApplicationController
  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = "Thanks! We've updated your streak."
      render :back
    else
      flash[:error] = "We weren't able to save your habit. Try again later."
      render :back
    end
  end

  private

  def event_params
    params.require(:event).permit(:completed, :repetitions, :habit_id, :created_at, :updated_at )
  end
end
