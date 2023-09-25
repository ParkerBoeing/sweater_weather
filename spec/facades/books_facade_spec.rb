require 'rails_helper'

RSpec.describe BooksFacade, type: :facade do
  describe '.book_search' do
    it 'returns a data hash with the correct attributes', :vcr do
      result = BooksFacade.book_search("denver,co", 5)
      expect(result).to be_a Hash
      expect(result[:books]).to all(be_a Book) 
      expect(result[:total_books_found]).to be_an Integer
    end
  end
end