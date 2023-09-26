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
      it "returns an error message for duplicate user" do
        user_params = {
          email: "whatever2@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
        post "/api/v0/users", params: user_params
        expect(response).to have_http_status(:success)
        post "/api/v0/users", params: user_params
        expect(response.status).to eq(400)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to eq({"error"=>"Validation failed: Email has already been taken"})     
      end

      it "returns an error message if password and confirmation dont match" do
        user_params = {
          email: "whatever@example.com",
          password: "password",
          password_confirmation: "password123"
        }
        post "/api/v0/users", params: user_params
        expect(response.status).to eq(400)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to eq({"error"=>"Validation failed: Password confirmation doesn't match Password"})
      end

      it "returns an error for missing parameters" do
        user_params = {
          email: "whatever@example.com",
          password: ""
        }
        post "/api/v0/users", params: user_params
        expect(response.status).to eq(400)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to eq({"error"=>"Invalid credentials"})
        
        user_params = {
          email: "",
          password: "password123"
        }
        post "/api/v0/users", params: user_params
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to eq({"error"=>"Invalid credentials"})
      end
    end
  end
end