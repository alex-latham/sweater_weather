class ForecastSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :location, :current, :hourly, :daily
end