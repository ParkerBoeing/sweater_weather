require 'rails_helper'

RSpec.describe LocationsFacade, type: :facade do
  describe '.get_coordinates' do
    it 'returns a Location object with the correct attributes', :vcr do
      location = "denver,co"

      result = LocationsFacade.get_coordinates(location)

      expect(result).to be_a Location
      expect(result.city).to eq('Denver')
      expect(result.state).to eq('CO')
      expect(result.lat).to be_a(Float)
      expect(result.lon).to be_a(Float)
    end
  end
end
