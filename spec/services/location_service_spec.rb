require "rails_helper"

describe LocationService do
  describe "instance methods" do
    describe "#get_coordinates" do
      it "returns the coordinates for a given location", :vcr do
        location_service = LocationService.new
        expect(location_service.get_coordinates("cincinatti,oh")).to eq({:info=>{:statuscode=>0, :copyright=>{:text=>"© 2023 MapQuest, Inc.", :imageUrl=>"http://api.mqcdn.com/res/mqlogo.gif", :imageAltText=>"© 2023 MapQuest, Inc."}, :messages=>[]},
        :options=>{:maxResults=>-1, :ignoreLatLngInput=>false},
        :results=>
         [{:providedLocation=>{:location=>"cincinatti,oh"},
           :locations=>
            [{:street=>"",
              :adminArea6=>"",
              :adminArea6Type=>"Neighborhood",
              :adminArea5=>"Cincinnati",
              :adminArea5Type=>"City",
              :adminArea4=>"Hamilton",
              :adminArea4Type=>"County",
              :adminArea3=>"OH",
              :adminArea3Type=>"State",
              :adminArea1=>"US",
              :adminArea1Type=>"Country",
              :postalCode=>"",
              :geocodeQualityCode=>"A5XBX",
              :geocodeQuality=>"CITY",
              :dragPoint=>false,
              :sideOfStreet=>"N",
              :linkId=>"0",
              :unknownInput=>"",
              :type=>"s",
              :latLng=>{:lat=>39.10713, :lng=>-84.50413},
              :displayLatLng=>{:lat=>39.10713, :lng=>-84.50413},
              :mapUrl=>""}]}]})
      end
    end
  end
end