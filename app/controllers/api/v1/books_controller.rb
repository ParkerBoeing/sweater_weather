class Api::V1::BooksController < ApplicationController

  def search
    if !params[:location] || params[:location] == ""
      render json: { errors: [{ detail: "Please enter valid location in this format: city,state(abbreviated)." }] }, status: :not_found
    elsif params[:quantity].to_i < 1
      render json: { errors: [{ detail: "Please enter valid quantity greater than zero." }] }, status: :not_found
    else
      location = LocationsFacade.get_coordinates(params[:location])
      forecast = ForecastsFacade.get_forecast(location)
      book_data = BooksFacade.book_search(params[:location], params[:quantity])
      render json: BookSearchSerializer.new(forecast, book_data, params[:location]).as_json
    end
  end
end