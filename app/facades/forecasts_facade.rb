class ForecastsFacade
  def self.get_forecast(location)
    service = WeatherService.new
    results = service.get_forecast(location)
    Forecast.new(results)
  end
end