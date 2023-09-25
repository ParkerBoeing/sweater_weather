class Api::V1::BooksController < ApplicationController

  def search
    location = LocationsFacade.get_coordinates(params[:location])
    forecast = ForecastsFacade.get_forecast(location)
    book_data = BooksFacade.book_search(params[:location], params[:quantity])
    render json: BookSearchSerializer.new(forecast, book_data, params[:location]).as_json
  end
end