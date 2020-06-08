require 'rails_helper'

RSpec.describe 'Client', type: :request do
  it 'can request forecast for a city' do
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
      expect(parsed_response[:data][:attributes][:current]).to_not have_key(:pressure)
      expect(parsed_response[:data][:attributes][:current]).to_not have_key(:dew_point)
      expect(parsed_response[:data][:attributes][:current]).to_not have_key(:clouds)
      expect(parsed_response[:data][:attributes][:current]).to_not have_key(:wind_speed)
      expect(parsed_response[:data][:attributes][:current]).to_not have_key(:wind_deg)
      expect(parsed_response[:data][:attributes][:current][:weather]).to have_key(:id)
      expect(parsed_response[:data][:attributes][:current][:weather]).to have_key(:main)
      expect(parsed_response[:data][:attributes][:current][:weather]).to have_key(:description)
      expect(parsed_response[:data][:attributes][:current][:weather]).to have_key(:icon)

      expect(parsed_response[:data][:attributes][:hourly].length).to eq(48)
      parsed_response[:data][:attributes][:hourly].each do |hour|
        expect(hour).to have_key(:dt)
        expect(hour).to have_key(:temp)
        expect(hour).to_not have_key(:feels_like)
        expect(hour).to_not have_key(:pressure)
        expect(hour).to_not have_key(:dew_point)
        expect(hour).to_not have_key(:clouds)
        expect(hour).to_not have_key(:wind_speed)
        expect(hour).to_not have_key(:wind_deg)
        expect(hour[:weather]).to have_key(:id)
        expect(hour[:weather]).to have_key(:main)
        expect(hour[:weather]).to have_key(:description)
        expect(hour[:weather]).to have_key(:icon)
      end

      expect(parsed_response[:data][:attributes][:daily].length).to eq(8)
      parsed_response[:data][:attributes][:daily].each do |day|
        expect(day).to have_key(:dt)
        expect(day).to have_key(:rain)
        expect(day[:temp]).to have_key(:min)
        expect(day[:temp]).to have_key(:max)
        expect(day[:temp]).to_not have_key(:day)
        expect(day[:temp]).to_not have_key(:night)
        expect(day[:temp]).to_not have_key(:eve)
        expect(day[:temp]).to_not have_key(:morn)
        expect(day[:weather]).to have_key(:id)
        expect(day[:weather]).to have_key(:main)
        expect(day[:weather]).to have_key(:description)
        expect(day[:weather]).to have_key(:icon)
      end
    end
  end
end
