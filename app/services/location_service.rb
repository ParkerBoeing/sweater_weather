class LocationService
  def conn
    Faraday.new(url: "https://www.mapquestapi.com/")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_coordinates(location)
    api_key = Rails.application.credentials.location_api[:key]
    url = "geocoding/v1/address?key=#{api_key}&location=#{location}"
    get_url(url)
  end

  def get_road_trip(origin, destination)
    api_key = Rails.application.credentials.location_api[:key]
    url = "directions/v2/route?key=#{api_key}&from=#{origin}&to=#{destination}"
    get_url(url)
  end
end