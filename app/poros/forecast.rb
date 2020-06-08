class Forecast
  attr_reader :id, :location, :current, :hourly, :daily

  def initialize(location, forecast_json)
    @id = nil
    @location = location
    @current = CurrentForecast.new(forecast_json[:current]).hash
    @hourly = HourlyForecast.new(forecast_json[:hourly]).hash
    @daily = DailyForecast.new(forecast_json[:daily]).hash
  end

  def self.from_geocoding(geocoding)
    forecast_json = OpenWeatherServices.new.get_forecast(geocoding)
    new(geocoding.formatted_address, forecast_json)
  end
end
