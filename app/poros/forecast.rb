class Forecast
  attr_reader :id, :location, :current, :hourly, :daily

  def initialize(location, forecast_json)
    @id = 0
    @location = location
    @current = filter_current(forecast_json[:current])
    @hourly = filter_hourly(forecast_json[:hourly])
    @daily = filter_daily(forecast_json[:daily])
  end

  def self.from_geocoding(geocoding)
    forecast_json = OpenWeatherServices.new.get_forecast(geocoding)
    new(geocoding.formatted_address, forecast_json)
  end

  private

  def filter_current(current_forecast_json)
    current_forecast_json.slice(
      :dt, :sunrise, :sunset, :temp, :feels_like,
      :humidity, :uvi, :visibility, :weather
    )
  end

  def filter_hourly(hourly_forecast_json)
    hourly_forecast_json.map do |hour|
      hour.slice(:dt, :temp, :weather)
    end
  end

  def filter_daily(daily_forecast_json)
    daily_forecast_json.map do |day|
      day.slice(:dt, :rain, :temp, :weather)
    end
  end
end
