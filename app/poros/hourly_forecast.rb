class HourlyForecast
  def self.prepare_hash(hourly_forecast_json)
    hourly_forecast_json.map do |hour|
      hour[:icon] = hour[:weather][0][:icon]
      hour[:datetime] = hour[:dt]
      filter_hour(hour)
    end
  end

  private

  def self.filter_hour(hour_forecast_json)
    hour_forecast_json.slice(:datetime, :icon, :temp)
  end
end
