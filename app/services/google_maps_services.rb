class GoogleMapsServices
  def get_geocoding(address)
    params = { key: ENV['GOOGLE_API_KEY'], address: address }
    path = '/maps/api/geocode/json'
    get_json(path, params)
  end

  def get_directions(origin, destination)
    params = { key: ENV['GOOGLE_API_KEY'], origin: origin, destination: destination }
    path = '/maps/api/directions/json'
    get_json(path, params)
  end

  private

  def get_json(path, params)
    response = conn.get(path, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://maps.googleapis.com')
  end
end
