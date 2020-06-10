require 'rails_helper'

RSpec.describe RoadTrip do
  describe 'class methods' do
    it 'plan(road_trip_params)' do
      VCR.use_cassette('road trip denver pueblo') do
        allow(Time).to receive(:now).and_return(Time.new(2020, 6, 9, 19, 55))
        
        user = create(:user)

        road_trip_params = {
          origin: 'denver,co',
          destination: 'pueblo,co',
          api_key: user.api_key
        }

        road_trip = RoadTrip.plan(road_trip_params)

        expect(road_trip.id).to be_nil
        expect(road_trip.origin[:city]).to eq('Denver')
        expect(road_trip.origin[:region]).to eq('CO')
        expect(road_trip.origin[:country]).to eq('United States')
        expect(road_trip.destination[:city]).to eq('Pueblo')
        expect(road_trip.destination[:region]).to eq('CO')
        expect(road_trip.destination[:country]).to eq('United States')
        expect(road_trip.travel_time).to eq('1 hour 48 mins')
        expect(road_trip.arrival_forecast[:temperature]).to eq(62.56)
        expect(road_trip.arrival_forecast[:description]).to eq('Clear Sky')
      end
    end
  end
end