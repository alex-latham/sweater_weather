require 'rails_helper'

RSpec.describe OpenWeatherServices do
  it 'can retrieve weather json for a city' do
    VCR.use_cassette('portland forecast') do
      location = Location.search('portland,or')
      forecast_json = OpenWeatherServices.new.get_forecast(location)

      expect(forecast_json[:current]).to have_key(:dt)
      expect(forecast_json[:current]).to have_key(:sunrise)
      expect(forecast_json[:current]).to have_key(:sunset)
      expect(forecast_json[:current]).to have_key(:temp)
      expect(forecast_json[:current]).to have_key(:feels_like)
      expect(forecast_json[:current]).to have_key(:humidity)
      expect(forecast_json[:current]).to have_key(:uvi)
      expect(forecast_json[:current]).to have_key(:pressure)
      expect(forecast_json[:current]).to have_key(:dew_point)
      expect(forecast_json[:current]).to have_key(:clouds)
      expect(forecast_json[:current]).to have_key(:wind_speed)
      expect(forecast_json[:current]).to have_key(:wind_deg)
      # expect(forecast_json[:current]).to have_key(:visibility)
      expect(forecast_json[:current][:weather][0]).to have_key(:id)
      expect(forecast_json[:current][:weather][0]).to have_key(:main)
      expect(forecast_json[:current][:weather][0]).to have_key(:description)
      expect(forecast_json[:current][:weather][0]).to have_key(:icon)

      expect(forecast_json[:hourly].length).to eq(48)
      forecast_json[:hourly].each do |hour|
        expect(hour).to have_key(:dt)
        expect(hour).to have_key(:temp)
        expect(hour).to have_key(:feels_like)
        expect(hour).to have_key(:pressure)
        expect(hour).to have_key(:dew_point)
        expect(hour).to have_key(:clouds)
        expect(hour).to have_key(:wind_speed)
        expect(hour).to have_key(:wind_deg)
        expect(hour[:weather][0]).to have_key(:id)
        expect(hour[:weather][0]).to have_key(:main)
        expect(hour[:weather][0]).to have_key(:description)
        expect(hour[:weather][0]).to have_key(:icon)
      end

      expect(forecast_json[:daily].length).to eq(8)
      forecast_json[:daily].each do |day|
        expect(day).to have_key(:dt)
        # expect(day).to have_key(:rain)
        expect(day[:temp]).to have_key(:min)
        expect(day[:temp]).to have_key(:max)
        expect(day[:temp]).to have_key(:day)
        expect(day[:temp]).to have_key(:night)
        expect(day[:temp]).to have_key(:eve)
        expect(day[:temp]).to have_key(:morn)
        expect(day[:weather][0]).to have_key(:id)
        expect(day[:weather][0]).to have_key(:main)
        expect(day[:weather][0]).to have_key(:description)
        expect(day[:weather][0]).to have_key(:icon)
      end
    end
  end
end
