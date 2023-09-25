require 'rails_helper'

RSpec.describe DailyWeather do
  describe 'attributes' do
    it 'initializes with the correct attributes' do
      data = {
        date: '2023-09-24',
        astro: {
          sunrise: '07:27 AM',
          sunset: '07:32 PM'
        },
        day: {
          maxtemp_f: 83.5,
          mintemp_f: 57.0,
          condition: {
            icon: '//cdn.weatherapi.com/weather/64x64/day/113.png',
            text: 'Sunny'
          }
        }
      }
      
      daily_weather = DailyWeather.new(data)
      
      expect(daily_weather.date).to eq('2023-09-24')
      expect(daily_weather.sunrise).to eq('07:27 AM')
      expect(daily_weather.sunset).to eq('07:32 PM')
      expect(daily_weather.icon).to eq('//cdn.weatherapi.com/weather/64x64/day/113.png')
      expect(daily_weather.max_temp).to eq(83.5)
      expect(daily_weather.min_temp).to eq(57.0)
      expect(daily_weather.condition).to eq('Sunny')
    end
  end
end
