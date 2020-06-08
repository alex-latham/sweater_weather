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
    directions = Directions.with_origin_destination(foodie_params[:start], foodie_params[:end])
    destination_geocoding = Geocoding.from_location_name(foodie_params[:end])
    forecast = Forecast.from_geocoding(destination_geocoding)
    restaurant = Restaurant.by_geocoding_and_cuisines(destination_geocoding, foodie_params[:search])
    foodie_info = self.prepare_foodie_info(foodie_params[:end], directions, forecast, restaurant)
    new(foodie_info)
  end

  private

  def self.prepare_foodie_info(end_location, directions, forecast, restaurant)
    { end_location: end_location,
      travel_time: directions.travel_time,
      forecast: {
        summary: forecast.current[:description],
        temperature: forecast.current[:temp]
      },
      restaurant: {
        name: restaurant.name,
        address: restaurant.address
      } }
  end
end
