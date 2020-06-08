require 'rails_helper'

RSpec.describe Forecast do
  describe 'class methods' do
    it 'from_geocoding' do
      VCR.use_cassette('portland forecast poro') do
        geocoding = Geocoding.from_location_name('portland,or')
        forecast = Forecast.from_geocoding(geocoding)

        expect(forecast.current).to have_key(:dt)
        expect(forecast.current).to have_key(:sunrise)
        expect(forecast.current).to have_key(:sunset)
        expect(forecast.current).to have_key(:temp)
        expect(forecast.current).to have_key(:feels_like)
        expect(forecast.current).to have_key(:humidity)
        expect(forecast.current).to have_key(:uvi)
        # expect(forecast.current).to have_key(:visibility)
        expect(forecast.current).to_not have_key(:pressure)
        expect(forecast.current).to_not have_key(:dew_point)
        expect(forecast.current).to_not have_key(:clouds)
        expect(forecast.current).to_not have_key(:wind_speed)
        expect(forecast.current).to_not have_key(:wind_deg)
        expect(forecast.current[:weather]).to have_key(:id)
        expect(forecast.current[:weather]).to have_key(:main)
        expect(forecast.current[:weather]).to have_key(:description)
        expect(forecast.current[:weather]).to have_key(:icon)

        expect(forecast.hourly.length).to eq(48)
        forecast.hourly.each do |hour|
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

        expect(forecast.daily.length).to eq(8)
        forecast.daily.each do |day|
          expect(day).to have_key(:dt)
          # expect(day).to have_key(:rain)
          expect(day).to_not have_key(:sunrise)
          expect(day).to_not have_key(:sunset)
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
end
