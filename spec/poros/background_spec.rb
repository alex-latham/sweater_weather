require 'rails_helper'

RSpec.describe Background do
  describe 'class methods' do
    it 'from_location' do
      VCR.use_cassette('denver background poro') do
        background = Background.from_location('denver,co')

        expected_url = 'https://images.unsplash.com/photo-1578983427937-26078ee3d9d3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjE0MDkwMX0'

        expect(background).to be_a(Background)
        expect(background.url).to eq(expected_url)
      end
    end
  end
end