class UnsplashServices
  def background_from_location(location)
    params = {
      query: location.name,
      client_id: ENV['UNSPLASH_CLIENT_ID']
    }
    path = '/search/photos'
    get_json(path, params)
  end

  private

  def get_json(path, params)
    response = conn.get(path, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.unsplash.com')
  end
end