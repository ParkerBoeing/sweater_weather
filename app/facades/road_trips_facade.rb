class RoadTripsFacade
  def self.road_trip(origin, destination)
    service = LocationService.new
    results = service.get_road_trip(origin, destination)
    raw_data = results[:route]
    RoadTrip.new(origin: origin,
                 destination: destination,
                 raw_time: raw_data[:time],
                 formatted_time: raw_data[:formattedTime]
                )
  end
end