require 'rails_helper'

RSpec.describe Location do
  describe 'class methods' do
    it 'search(denver,co)' do
      VCR.use_cassette('location denver') do
        location = Location.search('denver,co')

        expect(location).to be_a(Location)
        expect(location.city).to eq('Denver')
        expect(location.region).to eq('CO')
        expect(location.country).to eq('United States')
        expect(location.latitude).to eq(39.7392358)
        expect(location.longitude).to eq(-104.990251)
      end
    end

    it 'search(shinjuku,jp)' do
      VCR.use_cassette('location shinjuku') do
        location = Location.search('shinjuku,jp')

        expect(location).to be_a(Location)
        expect(location.city).to eq('Shinjuku City')
        expect(location.region).to eq('Tokyo')
        expect(location.country).to eq('Japan')
        expect(location.latitude).to eq(35.6938253)
        expect(location.longitude).to eq(139.7033559)
      end
    end

    it 'search(tokyo,jp) handles correctly with missing city' do
      VCR.use_cassette('location tokyo') do
        location = Location.search('tokyo,jp')

        expect(location).to be_a(Location)
        expect(location.city).to be_nil
        expect(location.region).to eq('Tokyo')
        expect(location.country).to eq('Japan')
        expect(location.latitude).to eq(35.6761919)
        expect(location.longitude).to eq(139.6503106)
      end
    end
  end
end
