class RoadTrip
  attr_reader :origin, :destination, :raw_time, :formatted_time

  def initialize(data)
    @origin = data[:origin]
    @destination = data[:destination]
    @raw_time = data[:raw_time]
    @formatted_time = data[:formatted_time]
  end

  def time_to_hours
    ((raw_time.to_f / 60) / 60).to_i
  end
end