require 'rails_helper'

RSpec.describe DailyForecast do
  describe 'class methods' do
    it 'prepare_hash' do
      VCR.use_cassette('portland daily forecast poro') do
        geocoding = Geocoding.from_location_name('portland,or')
        forecast_json = OpenWeatherServices.new.get_forecast(geocoding)
        daily_forecast = DailyForecast.new(forecast_json[:daily]).hash

        expect(daily_forecast.length).to eq(8)
        daily_forecast.each do |day|
          expect(day).to have_key(:datetime)
          expect(day).to have_key(:icon)
          expect(day).to have_key(:description)
          expect(day).to have_key(:max_temp)
          expect(day).to have_key(:min_temp)
          expect(day.length).to eq(6)
        end
      end
    end
  end
end
