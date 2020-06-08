class Geocoding
  attr_reader :formatted_address, :latitude, :longitude

  def initialize(geocoding_json)
    @formatted_address = geocoding_json[:results][0][:formatted_address]
    @latitude = geocoding_json[:results][0][:geometry][:location][:lat]
    @longitude = geocoding_json[:results][0][:geometry][:location][:lng]
  end

  def self.from_location_name(location_name)
    geocoding_json = GoogleMapsServices.new.get_geocoding(location_name)
    new(geocoding_json)
  end
end
