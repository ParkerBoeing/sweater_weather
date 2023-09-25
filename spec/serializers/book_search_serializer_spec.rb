require 'rails_helper'

RSpec.describe BookSearchSerializer do
  describe '#as_json' do
    it 'serializes a book search to the correct structure', :vcr do
      location = LocationsFacade.get_coordinates("Denver,CO")
      forecast = ForecastsFacade.get_forecast(location)
      book_data = BooksFacade.book_search("denver,co", 5)
      serializer = BookSearchSerializer.new(forecast, book_data, "denver,co")
      result = serializer.as_json

      expect(result).to eq({:data=>
      {:id=>"null",
       :type=>"books",
       :attributes=>
        {:destination=>"denver,co",
         :forecast=>{:summary=>"Sunny", :temperature=>"60.8 F"},
         :total_books_found=>772,
         :books=>
          [{:isbn=>["0762507845", "9780762507849"], :title=>"Denver, Co", :publisher=>["Universal Map Enterprises"]},
           {:isbn=>["9780607620054", "0607620056"], :title=>"Denver west, CO and Bailey, CO: Denver, CO", :publisher=>["USGS Branch of Distribution"]},
           {:isbn=>["0607620048", "9780607620047"], :title=>"Denver East, CO and Castle Rock, CO: Denver, CO", :publisher=>["USGS Branch of Distribution"]},
           {:isbn=>["9780528952715", "0528952714"], :title=>"Denver Regional, CO", :publisher=>["Rand McNally & Company"]},
           {:isbn=>["0762557362", "9780762557363"], :title=>"Denver Co Deluxe Flip Map", :publisher=>["Universal Map Enterprises"]}]}}})
    end
  end
end