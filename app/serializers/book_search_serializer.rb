class BookSearchSerializer
  def initialize(forecast, book_data, location)
    @forecast = forecast
    @num_of_books = book_data[:total_books_found]
    @books = book_data[:books]
    @location = location
  end

  def as_json
    {
      "data": {
        "id": "null",
        "type": "books",
        "attributes": {
          "destination": @location,
          "forecast": {
            "summary": @forecast.attributes[:current_weather].condition,
            "temperature": "#{@forecast.attributes[:current_weather].temperature} F"
          },
          "total_books_found": @num_of_books,
          "books": @books.map do |book| 
            {
              "isbn": book.isbn,
              "title": book.title,
              "publisher": book.publisher
            }
          end
        }
      }
    }
  end
end
