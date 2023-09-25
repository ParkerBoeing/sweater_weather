require "rails_helper"

RSpec.describe "Forecast Requests", type: :request do
  describe "GET /api/v0/forecast" do
    describe "happy path" do
      it "returns a successful response", :vcr do
        get "/api/v0/forecast?location=denver,co"
        expect(response).to have_http_status(:success)
        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expect(parsed_response).to be_a Hash
        expect(parsed_response).to have_key(:data)
        
        data = parsed_response[:data]
        expect(data).to have_key(:id)
        expect(data).to have_key(:type)
        expect(data).to have_key(:attributes)
        
        attributes = data[:attributes]
        expect(attributes).to have_key(:current_weather)
        expect(attributes).to have_key(:daily_weather)
        expect(attributes).to have_key(:hourly_weather)
      end
    end
  end
end