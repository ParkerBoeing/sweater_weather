require "rails_helper"

RSpec.describe "Road_trip Requests", type: :request do
  describe "POST /api/v0/road_trip" do
    describe "happy path" do
      it "returns a successful response for nearby destinations", :vcr do
        user = User.create!(email: "example@example.com", password: "password", password_confirmation: "password")
        road_trip_params = {
          "origin": "New York, NY",
          "destination": "Bedford, MA",
          "api_key": user.api_key
        }
        post "/api/v0/road_trip", params: road_trip_params
        expect(response).to have_http_status(:success)
        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expect(parsed_response).to be_a Hash
        expect(parsed_response).to have_key(:data)
        
        data = parsed_response[:data]
        expect(data).to have_key(:id)
        expect(data).to have_key(:type)
        expect(data).to have_key(:attributes)

        attributes = data[:attributes]
        expect(attributes).to have_key(:start_city)
        expect(attributes).to have_key(:end_city)
        expect(attributes).to have_key(:travel_time)
        expect(attributes).to have_key(:weather_at_eta)

        weather_at_eta = attributes[:weather_at_eta]
        expect(weather_at_eta).to have_key(:datetime)
        expect(weather_at_eta).to have_key(:temperature)
        expect(weather_at_eta).to have_key(:condition)
      end

      it "returns a successful response for far away destinations", :vcr do
        user = User.create!(email: "example@example.com", password: "password", password_confirmation: "password")
        road_trip_params = {
          "origin": "New York, NY",
          "destination": "Panama City, Panama",
          "api_key": user.api_key
        }
        post "/api/v0/road_trip", params: road_trip_params
        expect(response).to have_http_status(:success)
        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expect(parsed_response).to be_a Hash
        expect(parsed_response).to have_key(:data)
        
        data = parsed_response[:data]
        expect(data).to have_key(:id)
        expect(data).to have_key(:type)
        expect(data).to have_key(:attributes)

        attributes = data[:attributes]
        expect(attributes).to have_key(:start_city)
        expect(attributes).to have_key(:end_city)
        expect(attributes).to have_key(:travel_time)
        expect(attributes).to have_key(:weather_at_eta)

        weather_at_eta = attributes[:weather_at_eta]
        expect(weather_at_eta).to have_key(:datetime)
        expect(weather_at_eta).to have_key(:temperature)
        expect(weather_at_eta).to have_key(:condition)
      end

      it "returns a successful response with no forecast and impossible travel time for destinations that aren't driveable", :vcr do
        user = User.create!(email: "example@example.com", password: "password", password_confirmation: "password")
        road_trip_params = {
          "origin": "New York, NY",
          "destination": "London, UK",
          "api_key": user.api_key
        }
        post "/api/v0/road_trip", params: road_trip_params
        expect(response).to have_http_status(:success)
        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expect(parsed_response).to be_a Hash
        expect(parsed_response).to have_key(:data)
        
        data = parsed_response[:data]
        expect(data).to have_key(:id)
        expect(data).to have_key(:type)
        expect(data).to have_key(:attributes)

        attributes = data[:attributes]
        expect(attributes).to have_key(:start_city)
        expect(attributes).to have_key(:end_city)
        expect(attributes).to have_key(:travel_time)
        expect(attributes).to_not have_key(:weather_at_eta)
        expect(attributes[:travel_time]).to eq("Impossible")
      end
    end

    describe "sad path", :vcr do
      it "returns an unauthorized message for invalid api key" do
        user = User.create!(email: "example@example.com", password: "password", password_confirmation: "password")
        road_trip_params = {
          "origin": "New York, NY",
          "destination": "Bedford, MA",
          "api_key": "zztophats"
        }
        post "/api/v0/road_trip", params: road_trip_params

        expect(response.status).to eq(401)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to eq({"error"=>"Unauthorized"})     
      end
    end
  end
end