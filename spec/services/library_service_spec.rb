require "rails_helper"

describe LibraryService do
  describe "instance methods" do
    describe "#search_author" do
      it "searches for an author", :vcr do
        service = LibraryService.new
        response = service.search_by_location_name("denver,co", 5)
        expect(response).to be_a Hash
      end
    end
  end
end