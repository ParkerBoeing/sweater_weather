require 'rails_helper'

RSpec.describe HourlyWeather do
  describe 'attributes' do
    it 'initializes with the correct attributes' do
      data = {
        time: '2023-09-24 15:00',
        temp_f: 83.5,
        condition: {
          icon: '//cdn.weatherapi.com/weather/64x64/day/113.png',
          text: 'Sunny'
        }
      }
      
      hourly_weather = HourlyWeather.new(data)
      
      expect(hourly_weather.time).to eq('15:00')
      expect(hourly_weather.temperature).to eq(83.5)
      expect(hourly_weather.conditions).to eq('Sunny')
      expect(hourly_weather.icon).to eq('//cdn.weatherapi.com/weather/64x64/day/113.png')
    end
  end
end
