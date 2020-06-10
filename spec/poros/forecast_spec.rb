require 'rails_helper'

RSpec.describe Forecast do
  describe 'class methods' do
    it 'search(portland,or)' do
      VCR.use_cassette('forecast portland') do
        forecast = Forecast.search('portland,or')

        expect(forecast).to be_a(Forecast)

        expect(forecast.id).to eq(nil)

        expect(forecast.location[:city]).to eq('Portland')
        expect(forecast.location[:region]).to eq('OR')
        expect(forecast.location[:country]).to eq('United States')

        expect(forecast.current[:time]).to eq(1591659238)
        expect(forecast.current[:sunrise]).to eq(1591618941)
        expect(forecast.current[:sunset]).to eq(1591675063)
        expect(forecast.current[:temperature]).to eq(63.1)
        expect(forecast.current[:feels_like]).to eq(59.22)
        expect(forecast.current[:humidity]).to eq(51)
        expect(forecast.current[:uv_index]).to eq(7.41)
        expect(forecast.current[:uv_rating]).to eq('high')
        expect(forecast.current[:visibility]).to eq(16093)
        expect(forecast.current[:description]).to eq('Overcast Clouds')
        expect(forecast.current[:icon_url]).to eq('http://openweathermap.org/img/w/04d.png')
        expect(forecast.current.length).to eq(11)

        expect(forecast.hourly.length).to eq(48)
        forecast.hourly.each do |hour|
          expect(hour[:time]).to be_between(1591657200, 1591826400)
          expect(hour[:icon_url]).to include('http://openweathermap.org/img/w/')
          expect(hour[:icon_url]).to include('.png')
          expect(hour[:temperature]).to be_between(52, 76.69)
          expect(hour.length).to eq(3)
        end

        expect(forecast.daily.length).to eq(8)
        forecast.daily.each do |day|
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

    it 'uv_rating(uv_index)' do
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
