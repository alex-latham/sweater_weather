class OpenWeatherServices < BaseServices
  def get_forecast(location)
    path = '/data/2.5/onecall'
    params = {
      appid: ENV['OPEN_WEATHER_API_KEY'],
      lat: location.latitude,
      lon: location.longitude,
      units: 'imperial',
      exclude: 'minutely'
    }
    get_json(path, params)
  end

  private

  def conn
    Faraday.new(url: 'https://api.openweathermap.org')
  end
end
