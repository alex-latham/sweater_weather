require 'rails_helper'

RSpec.describe Background do
  describe 'class methods' do
    it 'from_location' do
      VCR.use_cassette('denver background poro') do
        location = Location.from_name('denver,co')
        background = Background.from_location(location)

        expect(background).to be_a(Background)
        expect(background.url).to eq('https://images.unsplash.com/photo-1578983427937-26078ee3d9d3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjE0MDkwMX0')
      end
    end
  end
end