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
      expect(data).to_not have_key(:location)
      expect(data).to_not have_key(:current)
      expect(data).to_not have_key(:forecast)
      
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

      expect(result).to eq({:data=>
      {:id=>nil,
       :type=>"forecast",
       :attributes=>
        {:current_weather=>
          {:last_updated=>"2023-09-24 19:30",
           :temperature=>63.0,
           :feels_like=>63.0,
           :icon=>"//cdn.weatherapi.com/weather/64x64/night/113.png",
           :humidity=>19,
           :uvi=>1.0,
           :visibility=>9.0,
           :condition=>"Clear"},
         :daily_weather=>
          [{:date=>"2023-09-24",
            :sunrise=>"06:49 AM",
            :sunset=>"06:54 PM",
            :icon=>"//cdn.weatherapi.com/weather/64x64/day/113.png",
            :max_temp=>78.8,
            :min_temp=>49.5,
            :condition=>"Sunny"},
           {:date=>"2023-09-25",
            :sunrise=>"06:50 AM",
            :sunset=>"06:52 PM",
            :icon=>"//cdn.weatherapi.com/weather/64x64/day/113.png",
            :max_temp=>82.6,
            :min_temp=>49.8,
            :condition=>"Sunny"},
           {:date=>"2023-09-26",
            :sunrise=>"06:51 AM",
            :sunset=>"06:51 PM",
            :icon=>"//cdn.weatherapi.com/weather/64x64/day/113.png",
            :max_temp=>86.2,
            :min_temp=>52.5,
            :condition=>"Sunny"},
           {:date=>"2023-09-27",
            :sunrise=>"06:52 AM",
            :sunset=>"06:49 PM",
            :icon=>"//cdn.weatherapi.com/weather/64x64/day/113.png",
            :max_temp=>86.3,
            :min_temp=>62.8,
            :condition=>"Sunny"},
           {:date=>"2023-09-28",
            :sunrise=>"06:53 AM",
            :sunset=>"06:47 PM",
            :icon=>"//cdn.weatherapi.com/weather/64x64/day/113.png",
            :max_temp=>88.9,
            :min_temp=>63.7,
            :condition=>"Sunny"}],
         :hourly_weather=>
          [{:time=>"00:00", :temperature=>62.4, :conditions=>"Clear", :icon=>"//cdn.weatherapi.com/weather/64x64/night/113.png"},
           {:time=>"01:00", :temperature=>60.6, :conditions=>"Clear", :icon=>"//cdn.weatherapi.com/weather/64x64/night/113.png"},
           {:time=>"02:00", :temperature=>58.6, :conditions=>"Clear", :icon=>"//cdn.weatherapi.com/weather/64x64/night/113.png"},
           {:time=>"03:00", :temperature=>56.8, :conditions=>"Clear", :icon=>"//cdn.weatherapi.com/weather/64x64/night/113.png"},
           {:time=>"04:00", :temperature=>54.5, :conditions=>"Clear", :icon=>"//cdn.weatherapi.com/weather/64x64/night/113.png"},
           {:time=>"05:00", :temperature=>52.5, :conditions=>"Partly cloudy", :icon=>"//cdn.weatherapi.com/weather/64x64/night/116.png"},
           {:time=>"06:00", :temperature=>50.9, :conditions=>"Partly cloudy", :icon=>"//cdn.weatherapi.com/weather/64x64/night/116.png"},
           {:time=>"07:00", :temperature=>49.5, :conditions=>"Sunny", :icon=>"//cdn.weatherapi.com/weather/64x64/day/113.png"},
           {:time=>"08:00", :temperature=>52.0, :conditions=>"Sunny", :icon=>"//cdn.weatherapi.com/weather/64x64/day/113.png"},
           {:time=>"09:00", :temperature=>59.7, :conditions=>"Sunny", :icon=>"//cdn.weatherapi.com/weather/64x64/day/113.png"},
           {:time=>"10:00", :temperature=>64.9, :conditions=>"Sunny", :icon=>"//cdn.weatherapi.com/weather/64x64/day/113.png"},
           {:time=>"11:00", :temperature=>73.8, :conditions=>"Sunny", :icon=>"//cdn.weatherapi.com/weather/64x64/day/113.png"},
           {:time=>"12:00", :temperature=>75.7, :conditions=>"Sunny", :icon=>"//cdn.weatherapi.com/weather/64x64/day/113.png"},
           {:time=>"13:00", :temperature=>77.2, :conditions=>"Sunny", :icon=>"//cdn.weatherapi.com/weather/64x64/day/113.png"},
           {:time=>"14:00", :temperature=>78.3, :conditions=>"Sunny", :icon=>"//cdn.weatherapi.com/weather/64x64/day/113.png"},
           {:time=>"15:00", :temperature=>78.8, :conditions=>"Sunny", :icon=>"//cdn.weatherapi.com/weather/64x64/day/113.png"},
           {:time=>"16:00", :temperature=>78.8, :conditions=>"Sunny", :icon=>"//cdn.weatherapi.com/weather/64x64/day/113.png"},
           {:time=>"17:00", :temperature=>78.3, :conditions=>"Sunny", :icon=>"//cdn.weatherapi.com/weather/64x64/day/113.png"},
           {:time=>"18:00", :temperature=>77.0, :conditions=>"Sunny", :icon=>"//cdn.weatherapi.com/weather/64x64/day/113.png"},
           {:time=>"19:00", :temperature=>63.0, :conditions=>"Clear", :icon=>"//cdn.weatherapi.com/weather/64x64/night/113.png"},
           {:time=>"20:00", :temperature=>68.9, :conditions=>"Clear", :icon=>"//cdn.weatherapi.com/weather/64x64/night/113.png"},
           {:time=>"21:00", :temperature=>67.5, :conditions=>"Clear", :icon=>"//cdn.weatherapi.com/weather/64x64/night/113.png"},
           {:time=>"22:00", :temperature=>65.8, :conditions=>"Clear", :icon=>"//cdn.weatherapi.com/weather/64x64/night/113.png"},
           {:time=>"23:00", :temperature=>63.5, :conditions=>"Clear", :icon=>"//cdn.weatherapi.com/weather/64x64/night/113.png"}]}}})
    end
  end
end
