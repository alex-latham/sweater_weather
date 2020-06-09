require 'rails_helper'

RSpec.describe 'Client', type: :request do
  xit 'can post a road trip' do
    get api_v1_road_trip_path(
      params: {
        start: 'denver,co',
        end: 'pueblo,co',
      }
    )

    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data][:id]).to eq(nil)
    expect(json[:data][:type]).to eq('road_trip')

    expect(json[:data][:attributes]).to have_key(:start_location)
    expect(json[:data][:attributes][:start_location]).to eq('Denver, CO, USA')
    expect(json[:data][:attributes]).to have_key(:end_location)
    expect(json[:data][:attributes][:end_location]).to eq('Pueblo, CO, USA')
    expect(json[:data][:attributes]).to have_key(:travel_time)
    expect(json[:data][:attributes]).to have_key(:forecast)
    expect(json[:data][:attributes][:forecast]).to have_key(:summary)
    expect(json[:data][:attributes][:forecast]).to have_key(:temperature)
    expect(json[:data][:attributes][:forecast].length).to eq(2)
    expect(json[:data][:attributes].length).to eq(4)
  end
end