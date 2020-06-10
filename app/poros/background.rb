class Background
  attr_reader :id, :url

  def initialize(background_info)
    @id = nil
    @url = background_info[:url]
  end

  def self.search(query)
    background_json = UnsplashServices.new.get_background(query)
    background_info = { url: background_json[:results][0][:urls][:raw] }
    new(background_info)
  end
end
