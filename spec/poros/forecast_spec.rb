require 'rails_helper'

RSpec.describe Forecast do
  describe 'class methods' do
    it 'from_geocoding' do
      VCR.use_cassette('portland forecast poro') do
        geocoding = Geocoding.from_location_name('portland,or')
        forecast = Forecast.from_geocoding(geocoding)

        expect(forecast.id).to eq(0)
        expect(forecast.location).to eq('Portland, OR, USA')

        expect(forecast.current).to have_key(:datetime)
        expect(forecast.current).to have_key(:sunrise)
        expect(forecast.current).to have_key(:sunset)
        expect(forecast.current).to have_key(:temp)
        expect(forecast.current).to have_key(:feels_like)
        expect(forecast.current).to have_key(:humidity)
        expect(forecast.current).to have_key(:uvi)
        expect(forecast.current).to have_key(:visibility)
        expect(forecast.current).to have_key(:icon)
        expect(forecast.current).to have_key(:description)
        expect(forecast.current[:description].chars.first).to eq(forecast.current[:description].chars.first.upcase)
        expect(forecast.current.length).to eq(10)

        expect(forecast.hourly.length).to eq(48)
        forecast.hourly.each do |hour|
          expect(hour).to have_key(:datetime)
          expect(hour).to have_key(:icon)
          expect(hour).to have_key(:temp)
          expect(hour.length).to eq(3)
        end

        expect(forecast.daily.length).to eq(8)
        forecast.daily.each do |day|
          expect(day).to have_key(:datetime)
          expect(day).to have_key(:max_temp)
          expect(day).to have_key(:min_temp)
          expect(day).to have_key(:icon)
          expect(day).to have_key(:description)
          expect(day[:description].chars.first).to eq(day[:description].chars.first.upcase)
          expect(day.length).to eq(6)
        end
      end
    end
  end
end
