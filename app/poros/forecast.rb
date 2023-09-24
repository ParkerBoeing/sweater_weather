class Forecast
  attr_reader :id, :type, :attributes

  def initialize(data)
    @id = nil
    @type = "forecast"
    @attributes = {
      current_weather: CurrentWeather.new(data[:current]),
      daily_weather: data[:forecast][:forecastday].map { |day| DailyWeather.new(day) },
      hourly_weather: data[:forecast][:forecastday][0][:hour].map { |hour| HourlyWeather.new(hour) }
                  }
  end
end