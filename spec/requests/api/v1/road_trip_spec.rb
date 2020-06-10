require 'rails_helper'

RSpec.describe 'Client', type: :request do
  it 'can post a road trip' do
    VCR.use_cassette('road trip denver pueblo') do
      allow(Time).to receive(:now).and_return(Time.new(2020, 6, 9, 19, 55))

      user = create(:user)

      road_trip_params = {
        origin: 'denver,co',
        destination: 'pueblo,co',
        api_key: user.api_key
      }

      post api_v1_road_trip_path(params: road_trip_params)

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data].length).to eq(3)
      expect(json[:data]).to have_key(:id)
      expect(json[:data][:id]).to be_nil
      expect(json[:data][:type]).to eq('road trip')
      expect(json[:data]).to have_key(:attributes)

      expect(json[:data][:attributes][:origin][:city]).to eq('Denver')
      expect(json[:data][:attributes][:origin][:region]).to eq('CO')
      expect(json[:data][:attributes][:origin][:country]).to eq('United States')
      expect(json[:data][:attributes][:destination][:city]).to eq('Pueblo')
      expect(json[:data][:attributes][:destination][:region]).to eq('CO')
      expect(json[:data][:attributes][:destination][:country]).to eq('United States')
      expect(json[:data][:attributes][:travel_time]).to eq('1 hour 48 mins')
      expect(json[:data][:attributes][:arrival_forecast][:time]).to eq(1591760579)
      expect(json[:data][:attributes][:arrival_forecast][:temperature]).to eq(63.46)
      expect(json[:data][:attributes][:arrival_forecast][:description]).to eq('Clear Sky')
    end
  end
end