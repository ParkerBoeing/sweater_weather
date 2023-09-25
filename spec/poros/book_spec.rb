require 'rails_helper'

RSpec.describe Book do
  describe 'attributes' do
    it 'has readable attributes' do
      data = {
        isbn: '1234',
        title: 'CO',
        publisher: ["Penguin Co"]
      }
      
      book = Book.new(data)
      
      expect(book.isbn).to eq('1234')
      expect(book.title).to eq('CO')
      expect(book.publisher).to eq(["Penguin Co"])
    end
  end
end
