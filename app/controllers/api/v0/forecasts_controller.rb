class Api::V0::ForecastsController < ApplicationController

  def show
    location = LocationsFacade.get_coordinates(params[:location])
    forecast = ForecastsFacade.get_forecast(location)
    render json: ForecastSerializer.new(forecast).as_json
  end
  
  def road_trip
    user = User.find_by(api_key: params[:api_key])
    if user
      response = LocationService.new.get_road_trip(params[:origin], params[:destination])
      require 'pry'; binding.pry
    else
      render json: { error: "Unauthorized" }, status: 401
    end
  end
end