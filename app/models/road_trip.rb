class RoadTrip < ApplicationRecord
  belongs_to :user
  
  attr_reader :id, :start_location, :end_location, :travel_time, :forecast

  def initialize(road_trip_info)
    @start_location = road_trip_info[:start_location]
    @end_location = road_trip_info[:end_location]
    @travel_time = road_trip_info[:travel_time]
    @forecast = road_trip_info[:forecast]
  end

  def self.plan(road_trip_params)
    User.find_by(api_key: road_trip_params[:api_key])
    directions = Directions.search(road_trip_params[:start], road_trip_params[:end])
    destination_geocoding = Geocoding.from_location_name(road_trip_params[:end])
    forecast = Forecast.from_geocoding(destination_geocoding)
    road_trip_info = prepare_road_trip_info(foodie_params[:end], directions, forecast)
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
