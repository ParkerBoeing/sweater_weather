require "rails_helper"

describe WeatherService do
  describe "instance methods" do
    describe "happy paths" do
      it "returns the current forecast + 5 days for a given location", :vcr do
        weather_service = WeatherService.new
        require 'pry'; binding.pry
        expect(weather_service.forecast("London")).to be_a Hash

      end
    end
  end
end