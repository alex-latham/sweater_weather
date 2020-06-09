class OpenWeatherServices
  def get_forecast(location)
    params = {
      lat: location.latitude,
      lon: location.longitude,
      units: 'imperial',
      exclude: 'minutely',
      appid: ENV['OPEN_WEATHER_API_KEY']
    }
    path = '/data/2.5/onecall'
    get_json(path, params)
  end

  private

  def get_json(path, params)
    response = conn.get(path, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.openweathermap.org')
  end
end
