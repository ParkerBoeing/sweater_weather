# class Api::V1::BooksController < ApplicationController

#   def search
#     location = LocationsFacade.get_coordinates(params[:location])
#     forecast = ForecastsFacade.get_forecast(location)
#     render json: BooksSerializer.new(forecast).as_json
#   end
# end