require 'rails_helper'

RSpec.describe Forecast do
  describe 'class methods' do
    it 'at_location' do
      VCR.use_cassette('portland forecast poro') do
        location = Location.from_name('portland,or')
        forecast = Forecast.at_location(location)

        expect(forecast.id).to eq(nil)
        expect(forecast.location).to eq('Portland, OR, USA')

        expect(forecast.current).to have_key(:datetime)
        expect(forecast.current).to have_key(:sunrise)
        expect(forecast.current).to have_key(:sunset)
        expect(forecast.current).to have_key(:temperature)
        expect(forecast.current).to have_key(:feels_like)
        expect(forecast.current).to have_key(:humidity)
        expect(forecast.current).to have_key(:uv_index)
        expect(forecast.current).to have_key(:uv_rating)
        expect(forecast.current).to have_key(:visibility)
        expect(forecast.current).to have_key(:icon_url)
        expect(forecast.current).to have_key(:description)
        expect(forecast.current.length).to eq(11)

        expect(forecast.hourly.length).to eq(48)
        forecast.hourly.each do |hour|
          expect(hour).to have_key(:datetime)
          expect(hour).to have_key(:icon_url)
          expect(hour).to have_key(:temperature)
          expect(hour.length).to eq(3)
        end

        expect(forecast.daily.length).to eq(8)
        forecast.daily.each do |day|
          expect(day).to have_key(:datetime)
          expect(day).to have_key(:max_temperature)
          expect(day).to have_key(:min_temperature)
          expect(day).to have_key(:icon_url)
          expect(day).to have_key(:summary)
          expect(day[:summary]).to eq(day[:summary].titleize)
          expect(day.length).to eq(6)
        end
      end
    end
  end
end
