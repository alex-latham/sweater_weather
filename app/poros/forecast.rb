class Forecast
  attr_reader :id, :location, :current, :hourly, :daily

  def initialize(forecast_info)
    @id = nil
    @location = forecast_info[:location]
    @current = forecast_info[:current]
    @hourly = forecast_info[:hourly]
    @daily = forecast_info[:daily]
  end

  def upon_arrival(arrival_datetime)

  end

  def self.at_location(location)
    forecast_json = OpenWeatherServices.new.get_forecast(location)
    current = current(forecast_json[:current])
    hourly = hourly(forecast_json[:hourly])
    daily = daily(forecast_json[:daily])
    forecast_info = {
      location: [location.city, location.region, location.country].join(', '),
      current: current,
      hourly: hourly,
      daily: daily
    }
    new(forecast_info)
  end

  def self.current(current_json)
    weather = current_json[:weather][0]
    current_json[:datetime] = current_json[:dt]
    current_json[:icon_url] = icon_url(weather[:icon])
    current_json[:description] = weather[:description].titlecase
    current_json[:temperature] = current_json[:temp]
    current_json[:uv_index] = current_json[:uvi]
    current_json[:uv_rating] = uv_rating(current_json[:uvi])
    current_json[:visibility] ||= nil
    filter_current(current_json)
  end

  def self.filter_current(current_json)
    current_json.slice(
      :datetime, :icon_url, :description, :sunrise, :sunset, :temperature,
      :feels_like, :humidity, :uv_index, :uv_rating, :visibility
    )
  end

  def self.hourly(hourly_json)
    hourly_json.map do |hour_json|
      hour_json[:datetime] = hour_json[:dt]
      hour_json[:icon_url] = icon_url(hour_json[:weather][0][:icon])
      hour_json[:temperature] = hour_json[:temp]
      filter_hour(hour_json)
    end
  end

  def self.filter_hour(hour_json)
    hour_json.slice(:datetime, :icon_url, :temperature)
  end

  def self.daily(daily_json)
    daily_json.map do |day_json|
      weather = day_json[:weather][0]
      day_json[:datetime] = day_json[:dt]
      day_json[:icon_url] = icon_url(weather[:icon])
      day_json[:summary] = weather[:main].titlecase
      day_json[:min_temperature] = day_json[:temp][:min]
      day_json[:max_temperature] = day_json[:temp][:max]
      day_json[:rain] ||= 0
      filter_day(day_json)
    end
  end

  def self.filter_day(day_json)
    day_json.slice(
      :datetime, :icon_url, :summary, :min_temperature, :max_temperature, :rain
    )
  end

  def self.uv_rating(uv_index)
    if uv_index >= 11
      'extreme'
    elsif uv_index >= 8
      'very high'
    elsif uv_index >= 6
      'high'
    elsif uv_index >= 3
      'moderate'
    elsif uv_index >= 1
      'low'
    else
      nil
    end
  end

  def self.icon_url(icon_id)
    "http://openweathermap.org/img/w/#{icon_id}.png"
  end
end
