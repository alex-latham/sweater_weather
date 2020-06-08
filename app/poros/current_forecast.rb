class CurrentForecast
  def prepare_hash(current_forecast_json)
    uv_index = current_forecast_json[:uvi].round(0)
    current_forecast_json[:uvi] = uv_index.to_s << uv_exposure(uv_index)
    weather = current_forecast_json[:weather][0]
    current_forecast_json[:description] = weather[:description]
    current_forecast_json[:icon] = weather[:icon]
    current_forecast_json[:datetime] = current_forecast_json[:dt]
    current_forecast_json[:visibility] ||= nil
    filter_current(current_forecast_json)
  end

  def uv_exposure(uv_index)
    ' (extreme)' if uv_index >= 11
    ' (very high)' if uv_index < 11
    ' (high)' if uv_index < 8
    ' (moderate)' if uv_index < 6
    ' (low)' if uv_index < 3
    '' if uv_index < 1
  end

  private

  def self.filter_current(current_forecast_json)
    current_forecast_json.slice(
      :datetime, :sunrise, :sunset, :temp, :feels_like,
      :humidity, :uvi, :visibility, :description, :icon
    )
  end
end
