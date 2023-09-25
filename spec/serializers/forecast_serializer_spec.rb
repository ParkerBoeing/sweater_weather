require 'rails_helper'

RSpec.describe ForecastSerializer do
  describe '#as_json' do
    it 'serializes a Forecast object to the correct structure', :vcr do
      location = LocationsFacade.get_coordinates("Denver, CO")
      forecast = ForecastsFacade.get_forecast(location)

      serializer = ForecastSerializer.new(forecast)

      result = serializer.as_json
      
      expect(result).to be_a Hash
      expect(result).to have_key(:data)
      
      data = result[:data]
      expect(data).to have_key(:id)
      expect(data).to have_key(:type)
      expect(data[:type]).to eq("forecast")
      expect(data).to have_key(:attributes)
      
      attributes = data[:attributes]
      expect(attributes).to have_key(:current_weather)
      expect(attributes).to have_key(:daily_weather)
      expect(attributes).to have_key(:hourly_weather)

      current_weather = attributes[:current_weather]
      expect(current_weather).to have_key(:last_updated)
      expect(current_weather).to have_key(:temperature)
      expect(current_weather).to have_key(:feels_like)
      expect(current_weather).to have_key(:icon)
      expect(current_weather).to have_key(:humidity)
      expect(current_weather).to have_key(:uvi)
      expect(current_weather).to have_key(:visibility)
      expect(current_weather).to have_key(:condition)
      
      daily_weather = attributes[:daily_weather]
      expect(daily_weather).to be_an(Array)
      daily_weather.each do |day|
        expect(day).to have_key(:date)
        expect(day).to have_key(:sunrise)
        expect(day).to have_key(:sunset)
        expect(day).to have_key(:icon)
        expect(day).to have_key(:max_temp)
        expect(day).to have_key(:min_temp)
        expect(day).to have_key(:condition)
      end
      
      hourly_weather = attributes[:hourly_weather]
      expect(hourly_weather).to be_an(Array)
      hourly_weather.each do |hour|
        expect(hour).to have_key(:time)
        expect(hour).to have_key(:temperature)
        expect(hour).to have_key(:conditions)
        expect(hour).to have_key(:icon)
      end
    end
  end
end
