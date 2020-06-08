class BaseServices
  def get_json(path, params, header = nil)
    response = conn.get(path, params) do |request|
      request.headers[header.first] = header.last unless header.nil?
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
