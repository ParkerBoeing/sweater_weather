require "rails_helper"

describe WeatherService do
  describe "instance methods" do
    describe "happy paths" do
      it "returns the current forecast + 5 days for a given location's coordinates", :vcr do
        weather_service = WeatherService.new
        location = LocationsFacade.get_coordinates("cincinatti,oh")
        expect(ForecastsFacade.get_forecast(location)).to be_a Forecast
      end
    end
  end
end