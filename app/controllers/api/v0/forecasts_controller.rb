class Api::V0::ForecastsController < ApplicationController

  def show
    location = LocationsFacade.get_coordinates(params[:location])
    forecast = ForecastsFacade.get_forecast(location)
    render json: ForecastSerializer.new(forecast).as_json
  end
end