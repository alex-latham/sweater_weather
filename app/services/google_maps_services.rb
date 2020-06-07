class GoogleMapsServices
  def get_coordinates(address)
    params = { key: ENV['GOOGLE_API_KEY'], address: address }
    path = '/maps/api/geocode/json'
    get_json(path, params)
  end

  private

  def conn
    Faraday.new(url: 'https://maps.googleapis.com')
  end

  def get_json(path, params)
    response = conn.get(path, params)

    JSON.parse(response.body, symbolize_names: true)
  end
end