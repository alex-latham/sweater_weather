class Location
  attr_reader :city, :region, :country, :latitude, :longitude

  def initialize(location_info)
    @city = location_info[:city]
    @region = location_info[:region]
    @country = location_info[:country]
    @latitude = location_info[:latitude]
    @longitude = location_info[:longitude]
  end

  def self.from_name(location_name)
    location_json = GoogleMapsServices.new.get_location(location_name)
    location_info = prepare_location_info(location_json)
    new(location_info)
  end

  def self.prepare_location_info(location_json)
    address_components = location_json[:results][0][:address_components]
    city = find_address_component(address_components, 'locality')
    region = find_address_component(address_components, 'administrative_area_level_1')
    country = find_address_component(address_components, 'country')
    latitude = location_json[:results][0][:geometry][:location][:lat]
    longitude = location_json[:results][0][:geometry][:location][:lng]
    { city: city, region: region, country: country, latitude: latitude, longitude: longitude }
  end

  def self.find_address_component(address_components, type)
    address_component = address_components.detect do |component|
      component[:types].include?(type)
    end
    type == 'country' ? address_component[:long_name]: address_component[:short_name]
  end
end
