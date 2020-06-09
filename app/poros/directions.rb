class Directions
  attr_reader :origin, :destination, :travel_time

  def initialize(directions_info)
    @origin = directions_info[:origin]
    @destination = directions_info[:destination]
    @travel_time = directions_info[:travel_time]
  end

  def self.search(origin, destination)
    directions_json = GoogleMapsServices.new.get_directions(origin, destination)
    origin = Location.search(origin)
    destination = Location.search(destination)
    directions_info = {
      origin: {
        city: origin.city,
        region: origin.region,
        country: origin.country
      },
      destination: {
        city: destination.city,
        region: destination.region,
        country: destination.country
      },
      travel_time: directions_json[:routes][0][:legs][0][:duration]
    }
    new(directions_info)
  end
end
