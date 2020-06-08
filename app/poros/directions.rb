class Directions
  attr_reader :travel_time

  def initialize(directions_info)
    @travel_time = directions_info[:travel_time]
  end

  def self.with_origin_destination(origin, destination)
    directions_json = GoogleMapsServices.new.get_directions(origin, destination)
    directions_info = {
      travel_time: directions_json[:routes][0][:legs][0][:duration][:text]
    }
    new(directions_info)
  end
end