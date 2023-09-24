require "rails_helper"

describe LocationService do
  describe "instance methods" do
    describe "happy paths" do
      it "returns the coordinates for a given location", :vcr do
        location_service = LocationService.new
        expect(location_service.get_coordinates("cincinatti,oh")).to be_a Hash

      end
    end
  end
end