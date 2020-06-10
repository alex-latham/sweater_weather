class RoadTrip
  attr_reader :id, :start_location, :end_location, :travel_time, :forecast

  def initialize(road_trip_info)
    @origin = road_trip_info[:origin]
    @destination = road_trip_info[:destination]
    @travel_time = road_trip_info[:travel_time]
    @forecast = road_trip_info[:forecast]
  end

  def self.plan(road_trip_params)
    user = User.find_by(api_key: road_trip_params[:api_key])
    return unless user.present?

    directions = Directions.search(road_trip_params[:origin], road_trip_params[:destination])
    forecast = Forecast.search(road_trip_params[:destination])
    arrival_forecast = forecast.at_time(Time.now + directions.travel_time[:value])
    road_trip_info = {
      origin: directions.origin,
      destination: directions.destination,
      travel_time: directions.travel_time[:text],
      forecast: arrival_forecast

    }
    new(road_trip_info)
  end

  def self.prepare_road_trip_info(end_location, directions, forecast)
    { end_location: end_location,
      travel_time: directions.travel_time,
      forecast: {
        summary: forecast.current[:description],
        temperature: forecast.current[:temp]
      } }
  end
end
