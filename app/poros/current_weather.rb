class CurrentWeather
  attr_reader :last_updated,
              :temperature,
              :feels_like,
              :icon,
              :humidity,
              :uvi,
              :visibility,
              :condition

  def initialize(data)
    @last_updated = data[:last_updated]
    @temperature = data[:temp_f]
    @feels_like = data[:feelslike_f]
    @icon = data[:condition][:icon]
    @humidity = data[:humidity]
    @uvi = data[:uv]
    @visibility = data[:vis_miles]
    @condition = data[:condition][:text]
  end
end