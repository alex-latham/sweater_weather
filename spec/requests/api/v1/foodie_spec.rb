require 'rails_helper'

RSpec.describe 'Client', type: :request do
  it 'can request food and forecast for a city' do
    get api_v1_fooodie_path(
      params: {
        start: 'denver,co',
        end: 'pueblo,co',
        search: 'italian'
      }
    )

    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data][:id]).to eq('null')
    expect(json[:data][:type]).to eq('foodie')

    expect(json[:data][:attributes].length).to eq(4)
    expect(json[:data][:attributes]).to have_key(:end_location)
    expect(json[:data][:attributes][:end_location]).to eq('pueblo,co')
    expect(json[:data][:attributes]).to have_key(:travel_time)
    expect(json[:data][:attributes]).to have_key(:forecast)
    expect(json[:data][:attributes][:forecast].length).to eq(2)
    expect(json[:data][:attributes][:forecast]).to have_key(:summary)
    expect(json[:data][:attributes][:forecast]).to have_key(:temperature)
    expect(json[:data][:attributes]).to have_key(:restaurant)
    expect(json[:data][:attributes][:restaurant].length).to eq(2)
    expect(json[:data][:attributes][:restaurant]).to have_key(:name)
    expect(json[:data][:attributes][:restaurant]).to have_key(:address)
  end
end