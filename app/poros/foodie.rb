class Foodie
  attr_reader :id, :end_location, :travel_time, :forecast, :restaurant

  def initialize(foodie_info)
    @id = nil
    @end_location = foodie_info[:end_location]
    @travel_time = foodie_info[:travel_time]
    @forecast = foodie_info[:forecast]
    @restaurant = foodie_info[:restaurant]
  end

  def self.search(foodie_params)
    destination_geocoding = Geocoding.from_location_name(foodie_params[:end])
    directions = Directions.with_origin_destination(foodie_params[:start], foodie_params[:end])
    restaurant_json = ZomatoServices.new.get_restaurant_json(destination_geocoding, foodie_params[:search])
    restaurant_location = restaurant_json[:restaurants][0][:restaurant][:location]
    forecast = Forecast.from_geocoding(destination_geocoding)

    foodie_info = {
      end_location: foodie_params[:end],
      travel_time: directions.travel_time,
      forecast: {
        summary: forecast.current[:description],
        temperature: forecast.current[:temp]
      },
      restaurant: {
        name: restaurant_json[:restaurants][0][:restaurant][:name],
        address: "#{restaurant_location[:address]}, #{restaurant_location[:city]}, #{restaurant_location[:zipcode]}"
      }
    }
    new(foodie_info)
  end
end