class Location
  attr_reader :name, :latitude, :longitude

  def initialize(location_info)
    @name = location_info[:name]
    @latitude = location_info[:latitude]
    @longitude = location_info[:longitude]
  end

  def self.from_name(location_name)
    location_json = GoogleMapsServices.new.get_location(location_name)
    location_info = prepare_location_info(location_json)
    new(location_info)
  end

  def self.prepare_location_info(location_json)
    name = location_json[:results][0][:formatted_address]
    latitude = location_json[:results][0][:geometry][:location][:lat]
    longitude = location_json[:results][0][:geometry][:location][:lng]
    { name: name, latitude: latitude, longitude: longitude }
  end
end
