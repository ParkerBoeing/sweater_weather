require "rails_helper"

RSpec.describe "Users Requests", type: :request do
  describe "POST /api/v0/users" do
    describe "happy path" do
      it "returns a successful response", :vcr do
        user_params = {
          email: "whatever2@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
        post "/api/v0/users", params: user_params
        expect(response).to have_http_status(:success)
        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expect(parsed_response).to be_a Hash
        expect(parsed_response).to have_key(:data)
        
        data = parsed_response[:data]
        expect(data).to have_key(:id)
        expect(data).to have_key(:type)
        expect(data).to have_key(:attributes)

        attributes = data[:attributes]
        expect(attributes).to have_key(:email)
        expect(attributes).to have_key(:api_key)
      end
    end
  end
end