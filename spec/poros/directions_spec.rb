require 'rails_helper'

RSpec.describe Directions do
  describe 'class methods' do
    it 'search(denver,co, pueblo,co)' do
      VCR.use_cassette('directions denver pueblo') do
        origin = 'denver,co'
        destination = 'pueblo,co'

        directions = Directions.search(origin, destination)

        expect(directions).to be_a(Directions)
        expect(directions.origin[:city]).to eq('Denver')
        expect(directions.origin[:region]).to eq('CO')
        expect(directions.origin[:country]).to eq('United States')
        expect(directions.destination[:city]).to eq('Pueblo')
        expect(directions.destination[:region]).to eq('CO')
        expect(directions.destination[:country]).to eq('United States')
        expect(directions.travel_time[:text]).to eq('1 hour 48 mins')
        expect(directions.travel_time[:value]).to eq(6479)
      end
    end
  end
end