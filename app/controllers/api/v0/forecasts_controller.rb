class Api::V0::ForecastsController < ApplicationController

  def show
    location = LocationsFacade.get_coordinates(params[:location])
    forecast = ForecastsFacade.get_forecast(location)
    render json: ForecastSerializer.new(forecast).as_json
  end
  
  def road_trip
    user = User.find_by(api_key: params[:api_key])
    if user
      road_trip = RoadTripsFacade.road_trip(params[:origin], params[:destination])
      if road_trip.raw_time
        location = LocationsFacade.get_coordinates(params[:destination])
        forecast = ForecastsFacade.get_forecast(location)
        arrival_time = (Time.now + road_trip.raw_time)
        if  Time.now.day == arrival_time.day
          forecast = forecast.attributes[:hourly_weather][(arrival_time.strftime("%H")).to_i]
          render json: RoadTripSerializer.new(road_trip, forecast).current_day_as_json
        else
          forecast = forecast.attributes[:daily_weather][(arrival_time.day - Time.now.day)]
          render json: RoadTripSerializer.new(road_trip, forecast).future_day_as_json
        end
      else
        render json: RoadTripSerializer.new(road_trip).impossible_trip_as_json
      end
    else
      render json: { error: "Unauthorized" }, status: 401
    end
  end
end