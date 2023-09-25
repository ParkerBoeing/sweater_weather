require 'rails_helper'

RSpec.describe CurrentWeather, type: :model do
  describe 'attributes' do
    let(:data) do
      {
        last_updated: '2023-09-24 20:15',
        temp_f: 73.9,
        feelslike_f: 77.2,
        condition: {
          icon: '//cdn.weatherapi.com/weather/64x64/night/122.png',
          text: 'Overcast'
        },
        humidity: 60,
        uv: 1.0,
        vis_miles: 9.0
      }
    end

    let(:current_weather) { CurrentWeather.new(data) }

    it 'initializes with the correct attributes' do
      expect(current_weather.last_updated).to eq('2023-09-24 20:15')
      expect(current_weather.temperature).to eq(73.9)
      expect(current_weather.feels_like).to eq(77.2)
      expect(current_weather.icon).to eq('//cdn.weatherapi.com/weather/64x64/night/122.png')
      expect(current_weather.humidity).to eq(60)
      expect(current_weather.uvi).to eq(1.0)
      expect(current_weather.visibility).to eq(9.0)
      expect(current_weather.condition).to eq('Overcast')
    end
  end
end
