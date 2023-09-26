class RoadTripSerializer
  def initialize(road_trip, forecast = nil)
    @road_trip = road_trip
    @forecast = forecast
  end

  def current_day_as_json
    { 
      "data": {
          "id": "null",
          "type": "road_trip",
          "attributes": {
              "start_city": @road_trip.origin,
              "end_city": @road_trip.destination,
              "travel_time": @road_trip.formatted_time,
              "weather_at_eta": {
                  "datetime": (Time.now + @road_trip.raw_time).strftime("%Y-%m-%d %H:%M:%S"),
                  "temperature": "#{@forecast.temperature} F",
                  "condition": @forecast.conditions
              }}}}
  end

  def future_day_as_json
    { 
      "data": {
          "id": "null",
          "type": "road_trip",
          "attributes": {
              "start_city": @road_trip.origin,
              "end_city": @road_trip.destination,
              "travel_time": @road_trip.formatted_time,
              "weather_at_eta": {
                  "datetime": (Time.now + @road_trip.raw_time).strftime("%Y-%m-%d %H:%M:%S"),
                  "temperature": "#{((@forecast.max_temp + @forecast.min_temp) / 2).round(1)} F",
                  "condition": @forecast.condition
              }}}}
  end

  def impossible_trip_as_json
    { 
      "data": {
          "id": "null",
          "type": "road_trip",
          "attributes": {
              "start_city": @road_trip.origin,
              "end_city": @road_trip.destination,
              "travel_time": "Impossible"
          }}}
  end
end