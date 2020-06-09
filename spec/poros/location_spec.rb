require 'rails_helper'

RSpec.describe Location do
  describe 'class methods' do
    it 'from_name' do
      VCR.use_cassette('denver location poro') do
        location = Location.from_name('denver,co')

        expect(location).to be_a(Location)
        expect(location.city).to eq('Denver')
        expect(location.region).to eq('CO')
        expect(location.country).to eq('United States')
        expect(location.latitude).to eq(39.7392358)
        expect(location.longitude).to eq(-104.990251)
      end
    end
  end
end
