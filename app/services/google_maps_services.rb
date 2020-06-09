class GoogleMapsServices < BaseServices
  def get_location(location_name)
    path = '/maps/api/geocode/json'
    params = {
      key: ENV['GOOGLE_API_KEY'],
      address: location_name
    }
    get_json(path, params)
  end

  def get_directions(start, destination)
    path = '/maps/api/directions/json'
    params = {
      key: ENV['GOOGLE_API_KEY'],
      origin: origin,
      destination: destination
    }
    get_json(path, params)
  end

  private

  def conn
    Faraday.new(url: 'https://maps.googleapis.com')
  end
end
