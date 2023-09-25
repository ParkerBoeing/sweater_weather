require 'rails_helper'

RSpec.describe Location do
  describe 'attributes' do
    it 'has readable attributes' do
      data = {
        city: 'Denver',
        state: 'CO',
        lat: 39.7392,
        lon: -104.9903
      }
      
      location = Location.new(data)
      
      expect(location.city).to eq('Denver')
      expect(location.state).to eq('CO')
      expect(location.lat).to eq(39.7392)
      expect(location.lon).to eq(-104.9903)
    end
  end
end
