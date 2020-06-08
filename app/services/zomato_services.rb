class ZomatoServices < BaseServices
  def get_entity_id_json(end_location)
    path = '/api/v2.1/locations'
    params = { query: end_location, count: 1 }
    header = ['user-key', ENV['ZOMATO_API_KEY']]
    get_json(path, params, header)
  end

  def get_restaurant_json(entity_id, cuisines)
    path = '/api/v2.1/search'
    params = { entity_id: entity_id, cuisines: cuisines, count: 1 }
    header = ['user-key', ENV['ZOMATO_API_KEY']]
    get_json(path, params, header)
  end

  private

  def conn
    Faraday.new(url: 'https://developers.zomato.com')
  end
end