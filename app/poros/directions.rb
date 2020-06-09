class Directions
  attr_reader :origin, :destination, :travel_time, :travel_time_value

  def initialize(directions_info)
    @origin = directions_info[:origin]
    @destination = directions_info[:destination]
    @travel_time = directions_info[:travel_time][:text]
    @travel_time_value = directions_info[:travel_time][:value]
  end

  def self.search(origin, destination)
    directions_json = GoogleMapsServices.new.get_directions(origin, destination)
    origin = Location.search(origin)
    destination = Location.search(destination)
    directions_info = {
      origin: [origin.city, origin.region].join(', '),
      destination: [destination.city, destination.region].join(', '),
      travel_time: directions_json[:routes][0][:legs][0][:duration]
    }
    new(directions_info)
  end
end
