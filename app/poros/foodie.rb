class Foodie
  attr_reader :id, :end_location, :travel_time, :forecast, :restaurant

  def initialize()
    @id = nil
    @end_location = nil
    @travel_time = nil
    @forecast = nil
    @restaurant = nil
  end

  def self.search(foodie_params)
    geocoding = Geocoding.from_location_name(foodie_params[:end])
    restaurant_json = ZomatoServices.new.get_restaurant_json(geocoding, cuisines)
    binding.pry
    restaurant = {
      name: restaurant_json[:restaurants][0][0][:name],
      address: estaurant_json[:restaurants][0][0][:location]
    }
  end
end