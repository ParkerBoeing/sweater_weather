class LibraryService
  def conn
    Faraday.new(url: "https://openlibrary.org/")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def search_by_location_name(location, quantity = 5)
    url = "search.json?q=#{location}&limit=#{quantity}"
    get_url(url)
  end
end