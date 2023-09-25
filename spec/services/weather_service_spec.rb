require "rails_helper"

describe WeatherService do
  describe "instance methods" do
    describe "#get_forecast" do
      it "returns the current forecast + 5 days for a given location's coordinates", :vcr do
        weather_service = WeatherService.new
        location = LocationsFacade.get_coordinates("cincinatti,oh")
        response = weather_service.get_forecast(location)
        expect(response).to be_a Hash
        expect(response[:location]).to be_a Hash
        expect(response[:current]).to be_a Hash
        expect(response[:forecast]).to be_a Hash
        expect(response[:forecast][:forecastday]).to be_an Array
        expect(response[:forecast][:forecastday].count).to eq(5)
        expect(response[:forecast][:forecastday][0][:hour].count).to eq(24)
      end
    end
  end
end