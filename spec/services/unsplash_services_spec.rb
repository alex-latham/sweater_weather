require 'rails_helper'

RSpec.describe UnsplashServices do
  it 'can retrieve backgrond json for a city' do
    VCR.use_cassette('portland background json') do
      location = Location.from_name('portland,or')
      background_json = UnsplashServices.new.background_from_location(location)

      expect(background_json[:results][0]).to have_key(:urls)
    end
  end
end
