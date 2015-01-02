class Api::V1::HabitsController < ApplicationController
  force_ssl unless Rails.env.development?
  before_action :authenticate, except: [:index, :show]
  respond_to :json, :xml

  def index
    respond_with Habit.all
  end

  def show
    respond_with Habit.find(params[:id])
  end

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      ApiKey.exists?(token: token)
    end
  end
end
