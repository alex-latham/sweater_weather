class RoadTrip
  attr_reader :id, :origin, :destination, :travel_time, :arrival_forecast

  def initialize(road_trip_info)
    @id = nil
    @origin = road_trip_info[:origin]
    @destination = road_trip_info[:destination]
    @travel_time = road_trip_info[:travel_time]
    @arrival_forecast = road_trip_info[:arrival_forecast]
  end

  def self.plan(road_trip_params)
    directions = Directions.search(road_trip_params[:origin], road_trip_params[:destination])
    forecast = Forecast.search(road_trip_params[:destination])
    arrival_time = Time.now.to_i + directions.travel_time[:value]
    arrival_forecast = forecast.at_time(arrival_time)
    road_trip_info = prepare_road_trip_info(directions, arrival_forecast)
    new(road_trip_info)
  end

  def self.prepare_road_trip_info(directions, arrival_forecast)
    {
      origin: directions.origin,
      destination: directions.destination,
      travel_time: directions.travel_time[:text],
      arrival_forecast: arrival_forecast
    }
  end
end
