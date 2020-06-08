require 'rails_helper'

RSpec.describe CurrentForecast do
  describe 'class methods' do
    it 'prepare_hash' do
      VCR.use_cassette('portland current forecast poro') do
        geocoding = Geocoding.from_location_name('portland,or')
        forecast_json = OpenWeatherServices.new.get_forecast(geocoding)
        current_forecast = CurrentForecast.prepare_hash(forecast_json[:current])

        expect(current_forecast).to have_key(:datetime)
        expect(current_forecast).to have_key(:sunrise)
        expect(current_forecast).to have_key(:sunset)
        expect(current_forecast).to have_key(:temp)
        expect(current_forecast).to have_key(:feels_like)
        expect(current_forecast).to have_key(:humidity)
        expect(current_forecast).to have_key(:uvi)
        expect(current_forecast).to have_key(:visibility)
        expect(current_forecast).to have_key(:description)
        expect(current_forecast).to have_key(:icon)
        expect(current_forecast.length).to eq(10)
      end
    end

    it 'uv_exposure' do
      expect(CurrentForecast.uv_exposure(0)).to eq(nil)
      expect(CurrentForecast.uv_exposure(1)).to eq(' (low)')
      expect(CurrentForecast.uv_exposure(2)).to eq(' (low)')
      expect(CurrentForecast.uv_exposure(3)).to eq(' (moderate)')
      expect(CurrentForecast.uv_exposure(4)).to eq(' (moderate)')
      expect(CurrentForecast.uv_exposure(5)).to eq(' (moderate)')
      expect(CurrentForecast.uv_exposure(6)).to eq(' (high)')
      expect(CurrentForecast.uv_exposure(7)).to eq(' (high)')
      expect(CurrentForecast.uv_exposure(8)).to eq(' (very high)')
      expect(CurrentForecast.uv_exposure(9)).to eq(' (very high)')
      expect(CurrentForecast.uv_exposure(10)).to eq(' (very high)')
      expect(CurrentForecast.uv_exposure(11)).to eq(' (extreme)')
      expect(CurrentForecast.uv_exposure(12)).to eq(' (extreme)')
    end
  end
end
