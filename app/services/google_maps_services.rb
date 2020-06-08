class GoogleMapsServices < BaseServices
  def get_geocoding(address)
    params = { key: ENV['GOOGLE_API_KEY'], address: address }
    path = '/maps/api/geocode/json'
    get_json(path, params)
  end

  private

  def conn
    Faraday.new(url: 'https://maps.googleapis.com')
  end
end
