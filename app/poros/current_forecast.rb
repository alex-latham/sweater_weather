class CurrentForecast
  attr_reader :hash

  def initialize(current_forecast_json)
    @hash = prepare_hash(current_forecast_json)
  end

  def uv_exposure(uv_index)
    if uv_index >= 11
      ' (extreme)'
    elsif uv_index >= 8
      ' (very high)'
    elsif uv_index >= 6
      ' (high)'
    elsif uv_index >= 3
      ' (moderate)'
    elsif uv_index >= 1
      ' (low)'
    else
      ''
    end
  end

  private

  def prepare_hash(current_forecast_json)
    uv_index = current_forecast_json[:uvi].round(0)
    current_forecast_json[:uvi] = uv_index.to_s << uv_exposure(uv_index)
    weather = current_forecast_json[:weather][0]
    current_forecast_json[:description] = weather[:description].titlecase
    current_forecast_json[:icon] = weather[:icon]
    current_forecast_json[:datetime] = current_forecast_json[:dt]
    current_forecast_json[:visibility] ||= nil
    filter_current(current_forecast_json)
  end

  def filter_current(current_forecast_json)
    current_forecast_json.slice(
      :datetime, :sunrise, :sunset, :temp, :feels_like,
      :humidity, :uvi, :visibility, :description, :icon
    )
  end
end
