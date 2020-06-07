class OpenWeatherServices < BaseServices
  def get_weather(latitude, longitude)
    params = {
      appid: ENV['OPEN_WEATHER_API_KEY'],
      lat: latitude,
      lon: longitude,
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