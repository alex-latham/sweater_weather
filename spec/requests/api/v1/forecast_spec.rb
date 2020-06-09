require 'rails_helper'

RSpec.describe 'Client', type: :request do
  it 'can get a full forecast' do
    VCR.use_cassette('portland forecast request') do
      get api_v1_forecast_path(params: { location: 'portland,or' })

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data]).to have_key(:id)
      expect(json[:data]).to have_key(:type)
      expect(json[:data]).to have_key(:attributes)
      expect(json[:data][:id]).to be_nil
      expect(json[:data][:type]).to eq('forecast')
      expect(json[:data].length).to eq(3)

      attributes = json[:data][:attributes]

      expect(attributes).to have_key(:location)
      expect(attributes).to have_key(:current)
      expect(attributes).to have_key(:hourly)
      expect(attributes).to have_key(:daily)
      expect(attributes[:location]).to eq('Portland, OR, USA')
      expect(attributes.length).to eq(4)

      current = attributes[:current]

      expect(current).to have_key(:datetime)
      expect(current).to have_key(:sunrise)
      expect(current).to have_key(:sunset)
      expect(current).to have_key(:temperature)
      expect(current).to have_key(:feels_like)
      expect(current).to have_key(:humidity)
      expect(current).to have_key(:uv_index)
      expect(current).to have_key(:uv_rating)
      expect(current).to have_key(:visibility)
      expect(current).to have_key(:description)
      expect(current).to have_key(:icon_url)
      expect(current.length).to eq(11)

      hourly = attributes[:hourly]

      hourly.each do |hour|
        expect(hour).to have_key(:datetime)
        expect(hour).to have_key(:icon_url)
        expect(hour).to have_key(:temperature)
        expect(hour.length).to eq(3)
      end
      expect(hourly.length).to eq(48)

      daily = attributes[:daily]

      daily.each do |day|
        expect(day).to have_key(:datetime)
        expect(day).to have_key(:icon_url)
        expect(day).to have_key(:summary)
        expect(day).to have_key(:rain)
        expect(day).to have_key(:max_temperature)
        expect(day).to have_key(:min_temperature)
        expect(day.length).to eq(6)
      end
      expect(daily.length).to eq(8)
    end
  end
end
