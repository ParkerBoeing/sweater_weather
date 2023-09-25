require 'rails_helper'

RSpec.describe ForecastsFacade, type: :facade do
  describe '.get_forecast' do
    it 'returns a Forecast object with the correct attributes', :vcr do
      location = LocationsFacade.get_coordinates("Denver,CO")

      result = ForecastsFacade.get_forecast(location)

      expect(result).to be_a Forecast
      expect(result.attributes[:current_weather]).to be_a CurrentWeather
      expect(result.attributes[:daily_weather]).to all(be_a DailyWeather)
      expect(result.attributes[:hourly_weather]).to all(be_a HourlyWeather)
    end
  end
end
