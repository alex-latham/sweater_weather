require 'rails_helper'

RSpec.describe Background do
  describe 'class methods' do
    it 'search(denver,co)' do
      VCR.use_cassette('background denver') do
        background = Background.search('denver,co')

        expected_url = 'https://images.unsplash.com/photo-1578983427937-26078ee3d9d3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjE0MDkwMX0'

        expect(background).to be_a(Background)
        expect(background.url).to eq(expected_url)
      end
    end

    it 'search(shinjuku,jp)' do
      VCR.use_cassette('background shinjuku') do
        background = Background.search('shinjuku,jp')

        expected_url = 'https://images.unsplash.com/photo-1570521462033-3015e76e7432?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjE0MDkwMX0'

        expect(background).to be_a(Background)
        expect(background.url).to eq(expected_url)
      end
    end
  end
end