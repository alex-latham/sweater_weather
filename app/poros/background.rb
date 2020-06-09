class Background
  attr_reader :id, :url

  def initialize(background_info)
    @id = nil
    @url = background_info[:url]
  end

  def self.from_location(location)
    background_json = UnsplashServices.new.background_from_location(location)
    url = background_json[:results][0][:urls][:raw]
    background_info = { url: url }
    new(background_info)
  end
end