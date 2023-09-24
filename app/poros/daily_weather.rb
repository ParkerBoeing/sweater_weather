class DailyWeather
  attr_reader :date,
              :sunrise,
              :sunset,
              :icon,
              :max_temp,
              :min_temp,
              :condition

  def initialize(data)
    @date = data[:date]
    @sunrise = data[:astro][:sunrise]
    @sunset = data[:astro][:sunset]
    @icon = data[:day][:condition][:icon]
    @max_temp = data[:day][:maxtemp_f]
    @min_temp = data[:day][:mintemp_f]
    @condition = data[:day][:condition][:text]
  end
end