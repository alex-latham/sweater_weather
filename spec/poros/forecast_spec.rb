require 'rails_helper'

RSpec.describe Forecast do
  describe 'class methods' do
    it 'search' do
      VCR.use_cassette('portland forecast') do
        forecast = Forecast.search('portland,or')

        expect(forecast).to be_a(Forecast)
        expect(forecast.id).to eq(nil)
        expect(forecast.location[:city]).to eq('Portland')
        expect(forecast.location[:region]).to eq('OR')
        expect(forecast.location[:country]).to eq('United States')

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
          expect(day[:summary]).to eq(day[:summary].titlecase)
          expect(day.length).to eq(6)
        end
      end
    end

    it 'uv_rating' do
      expect(Forecast.uv_rating(0)).to be_nil
      expect(Forecast.uv_rating(1)).to eq('low')
      expect(Forecast.uv_rating(2)).to eq('low')
      expect(Forecast.uv_rating(3)).to eq('moderate')
      expect(Forecast.uv_rating(4)).to eq('moderate')
      expect(Forecast.uv_rating(5)).to eq('moderate')
      expect(Forecast.uv_rating(5.5)).to eq('moderate')
      expect(Forecast.uv_rating(6)).to eq('high')
      expect(Forecast.uv_rating(7)).to eq('high')
      expect(Forecast.uv_rating(8)).to eq('very high')
      expect(Forecast.uv_rating(9)).to eq('very high')
      expect(Forecast.uv_rating(10)).to eq('very high')
      expect(Forecast.uv_rating(11)).to eq('extreme')
      expect(Forecast.uv_rating(12)).to eq('extreme')
    end
  end
end
