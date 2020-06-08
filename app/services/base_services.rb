class BaseServices
  def get_json(path, params)
    response = conn.get(path, params)
    JSON.parse(response.body, symbolize_names: true)
  end
end
