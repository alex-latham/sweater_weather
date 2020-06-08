class OpenWeatherServices < BaseServices
  def get_forecast(geocoding)
    params = {
      appid: ENV['OPEN_WEATHER_API_KEY'],
      lat: geocoding.latitude,
      lon: geocoding.longitude,
      exclude: 'minutely'
    }
    path = '/data/2.5/onecall'
    get_json(path, params)
  end

  private

  def conn
    Faraday.new(url: 'https://api.openweathermap.org')
  end
end
