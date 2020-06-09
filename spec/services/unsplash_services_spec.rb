require 'rails_helper'

RSpec.describe UnsplashServices do
  it 'can retrieve background json for a city' do
    VCR.use_cassette('background portland') do
      background_json = UnsplashServices.new.get_background('portland,or')

      expected_url = 'https://images.unsplash.com/photo-1500331882646-91f0854732b3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjE0MDkwMX0'

      expect(background_json[:results][0][:urls][:raw]).to eq(expected_url)
    end
  end
end
