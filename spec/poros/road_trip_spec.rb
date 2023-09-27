require 'rails_helper'

RSpec.describe RoadTrip do
  describe 'attributes' do
    it 'has readable attributes' do
      data = {
        origin: 'denver, co',
        destination: 'los angeles, ca',
        raw_time: 9845,
        formatted_time: "04:05:12"
      }
      
      road_trip = RoadTrip.new(data)
      
      expect(road_trip.origin).to eq('denver, co')
      expect(road_trip.destination).to eq('los angeles, ca')
      expect(road_trip.raw_time).to eq(9845)
      expect(road_trip.formatted_time).to eq("04:05:12")
    end
  end
end