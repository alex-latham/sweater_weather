class Forecast
  attr_reader :id, :location, :current, :hourly, :daily

  def initialize(location, forecast_json)
    @id = 0
    @location = location
    @current = forecast_json[:current]
    @hourly = forecast_json[:hourly]
    @daily = forecast_json[:daily]
  end

  def self.from_geocoding(geocoding)
    forecast_json = OpenWeatherServices.new.get_forecast(geocoding)
    new(geocoding.formatted_address, forecast_json)
  end
end