require 'rails_helper'

RSpec.describe HourlyForecast do
  describe 'class methods' do
    it 'prepare_hash' do
      VCR.use_cassette('portland hourly forecast poro') do
        geocoding = Geocoding.from_location_name('portland,or')
        forecast_json = OpenWeatherServices.new.get_forecast(geocoding)
        hourly_forecast = HourlyForecast.prepare_hash(forecast_json[:hourly])

        expect(hourly_forecast.length).to eq(48)
        hourly_forecast.each do |hour|
          expect(hour).to have_key(:datetime)
          expect(hour).to have_key(:icon)
          expect(hour).to have_key(:temp)
          expect(hour.length).to eq(3)
        end
      end
    end
  end
end
