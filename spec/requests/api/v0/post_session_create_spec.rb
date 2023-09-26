require "rails_helper"

RSpec.describe "Sessions Requests", type: :request do
  describe "POST /api/v0/sessions" do
    describe "happy path" do
      it "returns a successful response", :vcr do
        user_params = {
          email: "whatever2@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
        post "/api/v0/users", params: user_params
        expect(response).to have_http_status(:success)
        user_params = {
          email: "whatever2@example.com",
          password: "password123"
        }
        post "/api/v0/sessions", params: user_params
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

    describe "sad path", :vcr do
      it "returns an error for invalid credentials" do
        user_params = {
          email: "whatever2@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
        post "/api/v0/users", params: user_params
        expect(response).to have_http_status(:success)

        user_params = {
          email: "whateve@example.com",
          password: "password123"
        }
        post "/api/v0/sessions", params: user_params
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to eq({"error"=>"Invalid credentials"})
        
        user_params = {
          email: "whatever2@example.com",
          password: "passwor"
        }
        post "/api/v0/sessions", params: user_params
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to eq({"error"=>"Invalid credentials"})
      end
    end
  end
end