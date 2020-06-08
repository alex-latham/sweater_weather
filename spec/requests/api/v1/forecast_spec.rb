require 'rails_helper'

RSpec.describe 'Client', type: :request do
  it 'can request forecast for a city' do
    VCR.use_cassette('portland forecast request') do
      get api_v1_forecast_path(params: { location: 'portland,or' })

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:attributes].length).to eq(5)
      expect(json[:data][:attributes]).to have_key(:id)
      expect(json[:data][:attributes]).to have_key(:location)

      expect(json[:data][:attributes][:current]).to have_key(:datetime)
      expect(json[:data][:attributes][:current]).to have_key(:sunrise)
      expect(json[:data][:attributes][:current]).to have_key(:sunset)
      expect(json[:data][:attributes][:current]).to have_key(:temp)
      expect(json[:data][:attributes][:current]).to have_key(:feels_like)
      expect(json[:data][:attributes][:current]).to have_key(:humidity)
      expect(json[:data][:attributes][:current]).to have_key(:uvi)
      expect(json[:data][:attributes][:current]).to have_key(:visibility)
      expect(json[:data][:attributes][:current]).to have_key(:description)
      expect(json[:data][:attributes][:current]).to have_key(:icon)
      expect(json[:data][:attributes][:current].length).to eq(10)

      expect(json[:data][:attributes][:hourly].length).to eq(48)
      json[:data][:attributes][:hourly].each do |hour|
        expect(hour).to have_key(:datetime)
        expect(hour).to have_key(:icon)
        expect(hour).to have_key(:temp)
        expect(hour.length).to eq(3)
      end

      expect(json[:data][:attributes][:daily].length).to eq(8)
      json[:data][:attributes][:daily].each do |day|
        expect(day).to have_key(:datetime)
        expect(day).to have_key(:icon)
        expect(day).to have_key(:description)
        expect(day).to have_key(:rain)
        expect(day).to have_key(:max_temp)
        expect(day).to have_key(:min_temp)
        expect(day.length).to eq(6)
      end
    end
  end
end
