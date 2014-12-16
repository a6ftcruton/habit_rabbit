class HabitsController < ApplicationController

  def index
    @habit = Habit.new
  end

  def new
  end

  def create
    respond_to do |format|
      @habit = Habit.create(name: params[:name])
      if @habit.save!
        format.js {}
      else
        flash[:notice] = "Your habit must have a name"
        render :back
      end
    end
  end

  def show
  end
end
