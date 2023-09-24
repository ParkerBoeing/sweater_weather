class WeatherService
  def conn
    Faraday.new(url: "http://api.weatherapi.com/")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_forecast(location, days = 5)
    api_key = Rails.application.credentials.weather_api[:key]
    url = "v1/forecast.json?key=#{api_key}&q=#{location.lat},#{location.lon}&days=#{days}&aqi=no&alerts=no"
    get_url(url)
  end
end