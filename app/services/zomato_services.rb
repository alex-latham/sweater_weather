class ZomatoServices
  def get_restaurant_json(geocoding, cuisines)
    path = '/api/v2.1/search'
    params = {
      lat: geocoding.latitude,
      lon: geocoding.longitude,
      cuisines: cuisines,
      count: 1
    }
    header = ['user-key', ENV['ZOMATO_API_KEY']]
    get_json(path, params, header)
  end

  private

  def get_json(path, params, header = nil)
    response = conn.get(path, params) do |request|
      request.headers[header.first] = header.last unless header.nil?
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://developers.zomato.com')
  end
end