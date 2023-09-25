require 'rails_helper'

RSpec.describe Forecast, type: :poro do
  describe 'attributes' do
    it 'initializes with the correct attributes' do
      current_weather_data = attributes_for(:current_weather)
      daily_weather_data = Array.new(5) { attributes_for(:daily_weather) }
      hourly_weather_data = Array.new(24) { attributes_for(:hourly_weather) }

      forecast_data = {
        current: current_weather_data,
        forecast: {
          forecastday: daily_weather_data.map do |daily_data|
            daily_data.merge(hour: hourly_weather_data)
          end
        }
      }

      forecast = Forecast.new(forecast_data)
      expect(forecast).to be_a Forecast
      expect(forecast.id).to be_nil
      expect(forecast.type).to eq 'forecast'
      
      expect(forecast.attributes[:current_weather]).to be_a CurrentWeather
      expect(forecast.attributes[:daily_weather]).to all(be_a DailyWeather)
      expect(forecast.attributes[:hourly_weather]).to all(be_a HourlyWeather)
    end
  end
end
