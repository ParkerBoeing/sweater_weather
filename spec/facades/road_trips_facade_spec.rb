require 'rails_helper'

RSpec.describe RoadTripsFacade, type: :facade do
  describe '.get_coordinates' do
    it 'returns a Location object with the correct attributes', :vcr do
      location = "denver,co"

      result = RoadTripsFacade.road_trip("denver,co", "miami,fl")

      expect(result).to be_a RoadTrip
      expect(result.origin).to eq('denver,co')
      expect(result.destination).to eq('miami,fl')
      expect(result.raw_time).to be_an(Integer)
      expect(result.formatted_time).to be_a(String)
    end
  end
end
