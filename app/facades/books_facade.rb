class BooksFacade
  def self.book_search(location, quantity)
    service = LibraryService.new
    raw_books = service.search_by_location_name(location, quantity)
    books = raw_books[:docs].map do |book|
              Book.new(book)
            end
    data = {
            books: books,
            total_books_found: raw_books[:numFound]
          }

    data
  end
end