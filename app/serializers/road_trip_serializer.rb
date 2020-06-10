class RoadTripSerializer
  include FastJsonapi::ObjectSerializer

  set_type 'road trip'
  attributes :origin, :destination, :travel_time, :arrival_forecast
end
