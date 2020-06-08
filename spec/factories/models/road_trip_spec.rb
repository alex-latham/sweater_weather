require 'rails_helper'

RSpec.describe RoadTrip do
  describe 'class methods' do
    it 'plan' do
      road_trip_params = {
        start: 'denver,co',
        end: 'pueblo,co',
        api_key: SecureRandom.hex(16)
      }

      road_trip = RoadTrip.search(road_trip_params)

      expect(road_trip.id).to be_nil
      expect(road_trip.start_location).to eq('Denver, CO, USA')
      expect(road_trip.end_location).to eq('Pueblo, CO, USA')
      expect(road_trip.travel_time).to be_a(String)
      expect(road_trip.forecast).to have_key(:summary)
      expect(road_trip.forecast).to have_key(:temperature)
      expect(road_trip.forecast.length).to eq(2)
      expect(road_trip.forecast[:summary]).to be_a(String)
      expect(road_trip.forecast[:temperature]).to be_a(Float)
    end
  end
end