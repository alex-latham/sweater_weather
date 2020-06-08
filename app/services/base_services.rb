class BaseServices
  def get_json(path, params)
    binding.pry
    response = conn.get(path, params)
    JSON.parse(response.body, symbolize_names: true)
  end
end
