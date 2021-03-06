class UnsplashServices < BaseServices
  def get_background(query)
    path = '/search/photos'
    params = {
      client_id: ENV['UNSPLASH_CLIENT_ID'],
      query: query
    }
    get_json(path, params)
  end

  private

  def conn
    Faraday.new(url: 'https://api.unsplash.com')
  end
end
