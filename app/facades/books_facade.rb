class BooksFacade
  def self.book_search(location, quantity)
    service = LibraryService.new
    raw_books = service.search_by_location_name(location, quantity)
    raw_books[:docs].map do |book|
      Book.new(book)
    end
  end
end