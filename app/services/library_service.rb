class LibraryService
  def conn
    Faraday.new(url: "https://openlibrary.org/")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def search_author(author)
    url = "search/authors.json?q=#{author}"
    get_url(url)
  end
end