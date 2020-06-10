require 'rails_helper'

RSpec.describe 'Client', type: :request do
  it 'can get a full forecast' do
    VCR.use_cassette('forecast portland') do
      get api_v1_forecast_path(params: { location: 'portland,or' })

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data].length).to eq(3)
      expect(json[:data]).to have_key(:id)
      expect(json[:data][:id]).to be_nil
      expect(json[:data][:type]).to eq('forecast')
      expect(json[:data]).to have_key(:attributes)

      expect(json[:data][:attributes][:location][:city]).to eq('Portland')
      expect(json[:data][:attributes][:location][:region]).to eq('OR')
      expect(json[:data][:attributes][:location][:country]).to eq('United States')
      expect(json[:data][:attributes]).to have_key(:current)
      expect(json[:data][:attributes]).to have_key(:hourly)
      expect(json[:data][:attributes]).to have_key(:daily)
      expect(json[:data][:attributes].length).to eq(4)

      expect(json[:data][:attributes][:current][:time]).to eq(1591659238)
      expect(json[:data][:attributes][:current][:sunrise]).to eq(1591618941)
      expect(json[:data][:attributes][:current][:sunset]).to eq(1591675063)
      expect(json[:data][:attributes][:current][:temperature]).to eq(63.1)
      expect(json[:data][:attributes][:current][:feels_like]).to eq(59.22)
      expect(json[:data][:attributes][:current][:humidity]).to eq(51)
      expect(json[:data][:attributes][:current][:uv_index]).to eq(7.41)
      expect(json[:data][:attributes][:current][:uv_rating]).to eq('high')
      expect(json[:data][:attributes][:current][:visibility]).to eq(16093)
      expect(json[:data][:attributes][:current][:description]).to eq('Overcast Clouds')
      expect(json[:data][:attributes][:current][:icon_url]).to eq('http://openweathermap.org/img/w/04d.png')
      expect(json[:data][:attributes][:current].length).to eq(11)

      expect(json[:data][:attributes][:hourly].length).to eq(48)
      json[:data][:attributes][:hourly].each do |hour|
        expect(hour[:time]).to be_between(1591657200, 1591826400)
        expect(hour[:icon_url]).to include('http://openweathermap.org/img/w/')
        expect(hour[:icon_url]).to include('.png')
        expect(hour[:temperature]).to be_between(52, 76.69)
        expect(hour[:description]).to eq(hour[:description].titlecase)
        expect(hour.length).to eq(4)
      end

      expect(json[:data][:attributes][:daily].length).to eq(8)
      json[:data][:attributes][:daily].each do |day|
        expect(day[:time]).to be_between(1591646400, 1592251200)
        expect(day[:icon_url]).to include('http://openweathermap.org/img/w/')
        expect(day[:icon_url]).to include('.png')
        expect(day[:summary]).to eq(day[:summary].titlecase)
        expect(day[:rain]).to be_between(0.27, 19.48)
        expect(day[:max_temperature]).to be_between(57.96, 76.66)
        expect(day[:min_temperature]).to be_between(50.85, 59.09)
        expect(day.length).to eq(6)
      end
    end
  end
end
