require 'rails_helper'

RSpec.describe OpenWeatherServices do
  it "can retrieve weather for Denver (without rain/visibility)" do
    VCR.use_cassette("denver weather") do
      latitude = 39.7392358
      longitude = -104.990251

      weather_json = OpenWeatherServices.new.get_weather(latitude, longitude)

      expect(weather_json[:current]).to have_key(:dt)
      expect(weather_json[:current]).to have_key(:sunrise)
      expect(weather_json[:current]).to have_key(:sunset)
      expect(weather_json[:current]).to have_key(:temp)
      expect(weather_json[:current]).to have_key(:feels_like)
      expect(weather_json[:current]).to have_key(:humidity)
      expect(weather_json[:current]).to have_key(:uvi)
      expect(weather_json[:current][:weather][0]).to have_key(:id)
      expect(weather_json[:current][:weather][0]).to have_key(:main)
      expect(weather_json[:current][:weather][0]).to have_key(:description)
      expect(weather_json[:current][:weather][0]).to have_key(:icon)

      expect(weather_json[:daily].length).to eq(8)
      expect(weather_json[:daily][0]).to have_key(:dt)
      expect(weather_json[:daily][0][:temp]).to have_key(:min)
      expect(weather_json[:daily][0][:temp]).to have_key(:max)
      expect(weather_json[:daily][0][:weather][0]).to have_key(:id)
      expect(weather_json[:daily][0][:weather][0]).to have_key(:main)
      expect(weather_json[:daily][0][:weather][0]).to have_key(:description)
      expect(weather_json[:daily][0][:weather][0]).to have_key(:icon)

      expect(weather_json[:hourly].length).to eq(48)
      expect(weather_json[:hourly][0]).to have_key(:dt)
      expect(weather_json[:hourly][0]).to have_key(:temp)
    end
  end

  it "can retrieve weather for Seattle (with rain/visibility)" do
    VCR.use_cassette("seattle weather") do
      latitude = 47.6062095
      longitude = -122.3320708

      weather_json = OpenWeatherServices.new.get_weather(latitude, longitude)

      expect(weather_json[:current]).to have_key(:dt)
      expect(weather_json[:current]).to have_key(:sunrise)
      expect(weather_json[:current]).to have_key(:sunset)
      expect(weather_json[:current]).to have_key(:temp)
      expect(weather_json[:current]).to have_key(:feels_like)
      expect(weather_json[:current]).to have_key(:humidity)
      expect(weather_json[:current]).to have_key(:uvi)
      expect(weather_json[:current]).to have_key(:visibility)
      expect(weather_json[:current][:weather][0]).to have_key(:id)
      expect(weather_json[:current][:weather][0]).to have_key(:main)
      expect(weather_json[:current][:weather][0]).to have_key(:description)
      expect(weather_json[:current][:weather][0]).to have_key(:icon)

      expect(weather_json[:daily].length).to eq(8)
      expect(weather_json[:daily][0]).to have_key(:dt)
      expect(weather_json[:daily][0]).to have_key(:rain)
      expect(weather_json[:daily][0][:temp]).to have_key(:min)
      expect(weather_json[:daily][0][:temp]).to have_key(:max)
      expect(weather_json[:daily][0][:weather][0]).to have_key(:id)
      expect(weather_json[:daily][0][:weather][0]).to have_key(:main)
      expect(weather_json[:daily][0][:weather][0]).to have_key(:description)
      expect(weather_json[:daily][0][:weather][0]).to have_key(:icon)

      expect(weather_json[:hourly].length).to eq(48)
      expect(weather_json[:hourly][0]).to have_key(:dt)
      expect(weather_json[:hourly][0]).to have_key(:temp)
    end
  end
end