require 'rails_helper'

RSpec.describe RoadTripSerializer do
  describe '#current_day_as_json' do
    it 'serializes a forecast and destination to the correct structure when trip is current day', :vcr do
      road_trip = RoadTripsFacade.road_trip("moab,ut", "denver,co")
      location = LocationsFacade.get_coordinates("denver,co")
      forecast = ForecastsFacade.get_forecast(location)
      arrival_time = (Time.now + road_trip.raw_time)
      forecast = forecast.attributes[:hourly_weather][(arrival_time.strftime("%H")).to_i]
      serializer = RoadTripSerializer.new(road_trip, forecast).current_day_as_json

      result = serializer.as_json
      expect(result).to be_a Hash
      expect(result).to have_key("data")
      
      data = result["data"]
      expect(data).to have_key("id")
      expect(data).to have_key("type")
      expect(data["type"]).to eq("road_trip")
      expect(data).to have_key("attributes")
      
      attributes = data["attributes"]
      expect(attributes).to have_key("start_city")
      expect(attributes).to have_key("end_city")
      expect(attributes).to have_key("travel_time")
      expect(attributes).to have_key("weather_at_eta")

      weather_at_eta = attributes["weather_at_eta"]
      expect(weather_at_eta).to have_key("datetime")
      expect(weather_at_eta).to have_key("temperature")
      expect(weather_at_eta).to have_key("condition")
    end
  end

  describe '#future_day_as_json' do
    it 'serializes a forecast and destination to the correct structure when trip is future day', :vcr do
      road_trip = RoadTripsFacade.road_trip("moab,ut", "los angeles,ca")
      location = LocationsFacade.get_coordinates("los angeles,ca")
      forecast = ForecastsFacade.get_forecast(location)
      arrival_time = (Time.now + road_trip.raw_time)
      forecast = forecast.attributes[:daily_weather][(arrival_time.day - Time.now.day)]
      serializer = RoadTripSerializer.new(road_trip, forecast).future_day_as_json

      result = serializer.as_json
      expect(result).to be_a Hash
      expect(result).to have_key("data")
      
      data = result["data"]
      expect(data).to have_key("id")
      expect(data).to have_key("type")
      expect(data["type"]).to eq("road_trip")
      expect(data).to have_key("attributes")
      
      attributes = data["attributes"]
      expect(attributes).to have_key("start_city")
      expect(attributes).to have_key("end_city")
      expect(attributes).to have_key("travel_time")
      expect(attributes).to have_key("weather_at_eta")

      weather_at_eta = attributes["weather_at_eta"]
      expect(weather_at_eta).to have_key("datetime")
      expect(weather_at_eta).to have_key("temperature")
      expect(weather_at_eta).to have_key("condition")
    end
  end

  describe '#impossible_trip_as_json' do
    it 'serializes the proper response for an impossible trip', :vcr do
      road_trip = RoadTripsFacade.road_trip("moab,ut", "london,uk")
      serializer = RoadTripSerializer.new(road_trip).impossible_trip_as_json

      result = serializer.as_json
      expect(result).to be_a Hash
      expect(result).to have_key("data")
      
      data = result["data"]
      expect(data).to have_key("id")
      expect(data).to have_key("type")
      expect(data["type"]).to eq("road_trip")
      expect(data).to have_key("attributes")
      
      attributes = data["attributes"]
      expect(attributes).to have_key("start_city")
      expect(attributes).to have_key("end_city")
      expect(attributes).to have_key("travel_time")
      expect(attributes["travel_time"]).to eq("Impossible")
    end
  end
end
