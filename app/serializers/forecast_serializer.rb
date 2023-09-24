class ForecastSerializer
  def initialize(forecast)
    @forecast = forecast
  end

  def as_json
    {
      "data": {
        "id": nil,
        "type": "forecast",
        "attributes": {
          "current_weather": current_weather,
          "daily_weather": daily_weather,
          "hourly_weather": hourly_weather
        }
      }
    }
  end

  def current_weather
    cw = @forecast.attributes[:current_weather]
    {
      "last_updated": cw.last_updated,
      "temperature": cw.temperature,
      "feels_like": cw.feels_like,
      "icon": cw.icon,
      "humidity": cw.humidity,
      "uvi": cw.uvi,
      "visibility": cw.visibility,
      "condition": cw.condition
    }
  end

  def daily_weather
    @forecast.attributes[:daily_weather].map do |dw|
      {
        "date": dw.date,
        "sunrise": dw.sunrise,
        "sunset": dw.sunset,
        "icon": dw.icon,
        "max_temp": dw.max_temp,
        "min_temp": dw.min_temp,
        "condition": dw.condition
      }
    end
  end
  
  def hourly_weather
    @forecast.attributes[:hourly_weather].map do |hw|
      {
        "time": hw.time,
        "temperature": hw.temperature,
        "conditions": hw.conditions,
        "icon": hw.icon
      }
    end
  end
end
