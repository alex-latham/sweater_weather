require 'rails_helper'

RSpec.describe 'Client', type: :request do
  it 'can request forecast for a city (without rain/visibility)' do
    VCR.use_cassette('denver forecast request') do
      get api_v1_forecast_path(params: { location: 'denver,co' })

      expect(response).to be_successful

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response[:data][:attributes]).to have_key(:id)
      expect(parsed_response[:data][:attributes]).to have_key(:location)

      expect(parsed_response[:data][:attributes][:current]).to have_key(:dt)
      expect(parsed_response[:data][:attributes][:current]).to have_key(:sunrise)
      expect(parsed_response[:data][:attributes][:current]).to have_key(:sunset)
      expect(parsed_response[:data][:attributes][:current]).to have_key(:temp)
      expect(parsed_response[:data][:attributes][:current]).to have_key(:feels_like)
      expect(parsed_response[:data][:attributes][:current]).to have_key(:humidity)
      expect(parsed_response[:data][:attributes][:current]).to have_key(:uvi)
      expect(parsed_response[:data][:attributes][:current][:weather][0]).to have_key(:id)
      expect(parsed_response[:data][:attributes][:current][:weather][0]).to have_key(:main)
      expect(parsed_response[:data][:attributes][:current][:weather][0]).to have_key(:description)
      expect(parsed_response[:data][:attributes][:current][:weather][0]).to have_key(:icon)

      expect(parsed_response[:data][:attributes][:hourly].length).to eq(48)
      expect(parsed_response[:data][:attributes][:hourly][0]).to have_key(:dt)
      expect(parsed_response[:data][:attributes][:hourly][0]).to have_key(:temp)
      expect(parsed_response[:data][:attributes][:hourly][0][:weather][0]).to have_key(:id)
      expect(parsed_response[:data][:attributes][:hourly][0][:weather][0]).to have_key(:main)
      expect(parsed_response[:data][:attributes][:hourly][0][:weather][0]).to have_key(:description)
      expect(parsed_response[:data][:attributes][:hourly][0][:weather][0]).to have_key(:icon)

      expect(parsed_response[:data][:attributes][:daily].length).to eq(8)
      expect(parsed_response[:data][:attributes][:daily][0]).to have_key(:dt)
      expect(parsed_response[:data][:attributes][:daily][0][:temp]).to have_key(:min)
      expect(parsed_response[:data][:attributes][:daily][0][:temp]).to have_key(:max)
      expect(parsed_response[:data][:attributes][:daily][0][:weather][0]).to have_key(:id)
      expect(parsed_response[:data][:attributes][:daily][0][:weather][0]).to have_key(:main)
      expect(parsed_response[:data][:attributes][:daily][0][:weather][0]).to have_key(:description)
      expect(parsed_response[:data][:attributes][:daily][0][:weather][0]).to have_key(:icon)
    end
  end

  it 'can request forecast for a city (with rain/visibility)' do
    VCR.use_cassette('seattle forecast request') do
      get api_v1_forecast_path(params: { location: 'seattle,wa' })

      expect(response).to be_successful

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response[:data][:attributes]).to have_key(:id)
      expect(parsed_response[:data][:attributes]).to have_key(:location)

      expect(parsed_response[:data][:attributes][:current]).to have_key(:dt)
      expect(parsed_response[:data][:attributes][:current]).to have_key(:sunrise)
      expect(parsed_response[:data][:attributes][:current]).to have_key(:sunset)
      expect(parsed_response[:data][:attributes][:current]).to have_key(:temp)
      expect(parsed_response[:data][:attributes][:current]).to have_key(:feels_like)
      expect(parsed_response[:data][:attributes][:current]).to have_key(:humidity)
      expect(parsed_response[:data][:attributes][:current]).to have_key(:uvi)
      expect(parsed_response[:data][:attributes][:current]).to have_key(:visibility)
      expect(parsed_response[:data][:attributes][:current][:weather][0]).to have_key(:id)
      expect(parsed_response[:data][:attributes][:current][:weather][0]).to have_key(:main)
      expect(parsed_response[:data][:attributes][:current][:weather][0]).to have_key(:description)
      expect(parsed_response[:data][:attributes][:current][:weather][0]).to have_key(:icon)

      expect(parsed_response[:data][:attributes][:hourly].length).to eq(48)
      expect(parsed_response[:data][:attributes][:hourly][0]).to have_key(:dt)
      expect(parsed_response[:data][:attributes][:hourly][0]).to have_key(:temp)
      expect(parsed_response[:data][:attributes][:hourly][0][:weather][0]).to have_key(:id)
      expect(parsed_response[:data][:attributes][:hourly][0][:weather][0]).to have_key(:main)
      expect(parsed_response[:data][:attributes][:hourly][0][:weather][0]).to have_key(:description)
      expect(parsed_response[:data][:attributes][:hourly][0][:weather][0]).to have_key(:icon)

      expect(parsed_response[:data][:attributes][:daily].length).to eq(8)
      expect(parsed_response[:data][:attributes][:daily][0]).to have_key(:dt)
      expect(parsed_response[:data][:attributes][:daily][0]).to have_key(:rain)
      expect(parsed_response[:data][:attributes][:daily][0][:temp]).to have_key(:min)
      expect(parsed_response[:data][:attributes][:daily][0][:temp]).to have_key(:max)
      expect(parsed_response[:data][:attributes][:daily][0][:weather][0]).to have_key(:id)
      expect(parsed_response[:data][:attributes][:daily][0][:weather][0]).to have_key(:main)
      expect(parsed_response[:data][:attributes][:daily][0][:weather][0]).to have_key(:description)
      expect(parsed_response[:data][:attributes][:daily][0][:weather][0]).to have_key(:icon)
    end
  end
end
