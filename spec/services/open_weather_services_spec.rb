require 'rails_helper'

RSpec.describe OpenWeatherServices do
  it "can retrieve weather for Denver (without rain/visibility)" do
    VCR.use_cassette("denver forecast json") do
      geocoding = Geocoding.from_location_name("denver,co")
      forecast_json = OpenWeatherServices.new.get_forecast(geocoding)

      expect(forecast_json[:current]).to have_key(:dt)
      expect(forecast_json[:current]).to have_key(:sunrise)
      expect(forecast_json[:current]).to have_key(:sunset)
      expect(forecast_json[:current]).to have_key(:temp)
      expect(forecast_json[:current]).to have_key(:feels_like)
      expect(forecast_json[:current]).to have_key(:humidity)
      expect(forecast_json[:current]).to have_key(:uvi)
      expect(forecast_json[:current][:weather][0]).to have_key(:id)
      expect(forecast_json[:current][:weather][0]).to have_key(:main)
      expect(forecast_json[:current][:weather][0]).to have_key(:description)
      expect(forecast_json[:current][:weather][0]).to have_key(:icon)

      expect(forecast_json[:hourly].length).to eq(48)
      expect(forecast_json[:hourly][0]).to have_key(:dt)
      expect(forecast_json[:hourly][0]).to have_key(:temp)
      expect(forecast_json[:hourly][0][:weather][0]).to have_key(:id)
      expect(forecast_json[:hourly][0][:weather][0]).to have_key(:main)
      expect(forecast_json[:hourly][0][:weather][0]).to have_key(:description)
      expect(forecast_json[:hourly][0][:weather][0]).to have_key(:icon)


      expect(forecast_json[:daily].length).to eq(8)
      expect(forecast_json[:daily][0]).to have_key(:dt)
      expect(forecast_json[:daily][0][:temp]).to have_key(:min)
      expect(forecast_json[:daily][0][:temp]).to have_key(:max)
      expect(forecast_json[:daily][0][:weather][0]).to have_key(:id)
      expect(forecast_json[:daily][0][:weather][0]).to have_key(:main)
      expect(forecast_json[:daily][0][:weather][0]).to have_key(:description)
      expect(forecast_json[:daily][0][:weather][0]).to have_key(:icon)
    end
  end

  it "can retrieve weather for Seattle (with rain/visibility)" do
    VCR.use_cassette("seattle forecast json") do
      geocoding = Geocoding.from_location_name("seattle,wa")
      forecast_json = OpenWeatherServices.new.get_forecast(geocoding)

      expect(forecast_json[:current]).to have_key(:dt)
      expect(forecast_json[:current]).to have_key(:sunrise)
      expect(forecast_json[:current]).to have_key(:sunset)
      expect(forecast_json[:current]).to have_key(:temp)
      expect(forecast_json[:current]).to have_key(:feels_like)
      expect(forecast_json[:current]).to have_key(:humidity)
      expect(forecast_json[:current]).to have_key(:uvi)
      expect(forecast_json[:current]).to have_key(:visibility)
      expect(forecast_json[:current][:weather][0]).to have_key(:id)
      expect(forecast_json[:current][:weather][0]).to have_key(:main)
      expect(forecast_json[:current][:weather][0]).to have_key(:description)
      expect(forecast_json[:current][:weather][0]).to have_key(:icon)

      expect(forecast_json[:hourly].length).to eq(48)
      expect(forecast_json[:hourly][0]).to have_key(:dt)
      expect(forecast_json[:hourly][0]).to have_key(:temp)
      expect(forecast_json[:hourly][0][:weather][0]).to have_key(:id)
      expect(forecast_json[:hourly][0][:weather][0]).to have_key(:main)
      expect(forecast_json[:hourly][0][:weather][0]).to have_key(:description)
      expect(forecast_json[:hourly][0][:weather][0]).to have_key(:icon)

      expect(forecast_json[:daily].length).to eq(8)
      expect(forecast_json[:daily][0]).to have_key(:dt)
      expect(forecast_json[:daily][0]).to have_key(:rain)
      expect(forecast_json[:daily][0][:temp]).to have_key(:min)
      expect(forecast_json[:daily][0][:temp]).to have_key(:max)
      expect(forecast_json[:daily][0][:weather][0]).to have_key(:id)
      expect(forecast_json[:daily][0][:weather][0]).to have_key(:main)
      expect(forecast_json[:daily][0][:weather][0]).to have_key(:description)
      expect(forecast_json[:daily][0][:weather][0]).to have_key(:icon)
    end
  end
end