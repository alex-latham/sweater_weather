class ForecastSerializer
  include FastJsonapi::ObjectSerializer

  set_type 'forecast'
  attributes :location, :current, :hourly, :daily
end
