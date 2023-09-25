require "rails_helper"

RSpec.describe "Book Search Requests", type: :request do
  describe "GET /api/v1/book-search" do
    describe "happy path" do
      it "returns a successful response", :vcr do
        get "/api/v1/book-search?location=denver,co&quantity=5"
        expect(response).to have_http_status(:success)
        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expect(parsed_response).to be_a Hash
        expect(parsed_response).to have_key(:data)
        
        data = parsed_response[:data]
        expect(data).to have_key(:id)
        expect(data).to have_key(:type)
        expect(data).to have_key(:attributes)
        
        attributes = data[:attributes]
        expect(attributes).to have_key(:destination)
        expect(attributes).to have_key(:forecast)
        expect(attributes).to have_key(:total_books_found)
        expect(attributes).to have_key(:books)

        forecast = attributes[:forecast]
        expect(forecast).to have_key(:summary)
        expect(forecast).to have_key(:temperature)

        books = attributes[:books]
        books.each do |book|
          expect(book).to have_key(:isbn)
          expect(book).to have_key(:title)
          expect(book).to have_key(:publisher)
        end
      end
    end
  end
end