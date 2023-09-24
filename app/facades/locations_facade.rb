class LocationsFacade
  def self.get_coordinates(location)
    service = LocationService.new
    results = service.get_coordinates(location)
    raw_location = results[:results][0][:locations][0]
    Location.new(city: raw_location[:adminArea5],
                 state: raw_location[:adminArea3],
                 lat: raw_location[:latLng][:lat],
                 lon: raw_location[:latLng][:lng]
                )
  end
end