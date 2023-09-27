class RoadTrip
  attr_reader :origin, :destination, :raw_time, :formatted_time

  def initialize(data)
    @origin = data[:origin]
    @destination = data[:destination]
    @raw_time = data[:raw_time]
    @formatted_time = data[:formatted_time]
  end

  def format_arrival_time
    (Time.now + raw_time).strftime("%Y-%m-%d %H:%M:%S")
  end
end