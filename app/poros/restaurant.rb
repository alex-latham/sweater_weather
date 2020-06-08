class Restaurant
  attr_reader :name, :address

  def initialize(restaurant_info)
    @name = restaurant_info[:name]
    @address = restaurant_info[:address]
  end

  def self.by_geocoding_and_cuisines(geocoding, cuisines)
    restaurant_json = ZomatoServices.new.get_restaurant_json(geocoding, cuisines)
    location = restaurant_json[:restaurants][0][:restaurant][:location]
    restaurant_info = {
      name: restaurant_json[:restaurants][0][:restaurant][:name],
      address: "#{location[:address]}, #{location[:city]}, #{location[:zipcode]}"
    }
    new(restaurant_info)
  end
end
