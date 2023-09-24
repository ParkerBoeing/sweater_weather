class Location
  attr_reader :city,
              :state,
              :lat,
              :lon

  def initialize(data)
    @city = data[:city]
    @state = data[:state]
    @lat = data[:lat]
    @lon = data[:lon]
  end
end