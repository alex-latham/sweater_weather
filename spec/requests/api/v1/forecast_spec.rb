require 'rails_helper'

RSpec.describe 'Client', type: :request do
  it 'can get a full forecast' do
    VCR.use_cassette('forecast portland') do
      get api_v1_forecast_path(params: { location: 'portland,or' })

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data]).to have_key(:id)
      expect(json[:data][:id]).to be_nil
      expect(json[:data][:type]).to eq('forecast')
      expect(json[:data]).to have_key(:attributes)
      expect(json[:data].length).to eq(3)

      attributes = json[:data][:attributes]

      expect(attributes[:location][:city]).to eq('Portland')
      expect(attributes[:location][:region]).to eq('OR')
      expect(attributes[:location][:country]).to eq('United States')
      expect(attributes).to have_key(:current)
      expect(attributes).to have_key(:hourly)
      expect(attributes).to have_key(:daily)
      expect(attributes.length).to eq(4)

      expect(attributes[:current][:datetime]).to eq(1591659238)
      expect(attributes[:current][:sunrise]).to eq(1591618941)
      expect(attributes[:current][:sunset]).to eq(1591675063)
      expect(attributes[:current][:temperature]).to eq(63.1)
      expect(attributes[:current][:feels_like]).to eq(59.22)
      expect(attributes[:current][:humidity]).to eq(51)
      expect(attributes[:current][:uv_index]).to eq(7.41)
      expect(attributes[:current][:uv_rating]).to eq('high')
      expect(attributes[:current][:visibility]).to eq(16093)
      expect(attributes[:current][:description]).to eq('Overcast Clouds')
      expect(attributes[:current][:icon_url]).to eq('http://openweathermap.org/img/w/04d.png')
      expect(attributes[:current].length).to eq(11)

      expect(attributes[:hourly].length).to eq(48)
      attributes[:hourly].each do |hour|
        expect(hour[:datetime]).to be_between(1591657200, 1591826400)
        expect(hour[:icon_url]).to include('http://openweathermap.org/img/w/')
        expect(hour[:icon_url]).to include('.png')
        expect(hour[:temperature]).to be_between(52, 76.69)
        expect(hour.length).to eq(3)
      end

      expect(attributes[:daily].length).to eq(8)
      attributes[:daily].each do |day|
        expect(day[:datetime]).to be_between(1591646400, 1592251200)
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
