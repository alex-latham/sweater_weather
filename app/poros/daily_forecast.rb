class DailyForecast
  attr_reader :hash

  def initialize(daily_forecast_json)
    @hash = prepare_hash(daily_forecast_json)
  end

  private

  def prepare_hash(daily_forecast_json)
    daily_forecast_json.map do |day|
      weather = day[:weather][0]
      day[:description] = weather[:main].titlecase
      day[:icon] = 'http://openweathermap.org/img/w/' + weather[:icon] + '.png'
      day[:min_temp] = day[:temp][:min]
      day[:max_temp] = day[:temp][:max]
      day[:datetime] = day[:dt]
      day[:rain] ||= 0
      filter_day(day)
    end
  end

  def filter_day(day_forecast_json)
    day_forecast_json.slice(
      :datetime, :rain, :min_temp,
      :max_temp, :description, :icon
    )
  end
end
