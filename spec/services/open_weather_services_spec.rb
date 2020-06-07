require 'rails_helper'

RSpec.describe OpenWeatherServices do
  it "can retrieve weather for Denver (without rain/visibility)" do
    VCR.use_cassette("denver weather") do
      latitude = 39.7392358
      longitude = -104.990251

      denver_weather = OpenWeatherServices.new.get_weather(latitude, longitude)

      expect(denver_weather[:current]).to have_key(:dt)
      expect(denver_weather[:current]).to have_key(:sunrise)
      expect(denver_weather[:current]).to have_key(:sunset)
      expect(denver_weather[:current]).to have_key(:temp)
      expect(denver_weather[:current]).to have_key(:feels_like)
      expect(denver_weather[:current]).to have_key(:humidity)
      expect(denver_weather[:current]).to have_key(:uvi)
      expect(denver_weather[:current][:weather][0]).to have_key(:id)
      expect(denver_weather[:current][:weather][0]).to have_key(:main)
      expect(denver_weather[:current][:weather][0]).to have_key(:description)
      expect(denver_weather[:current][:weather][0]).to have_key(:icon)

      expect(denver_weather[:daily].length).to eq(8)
      expect(denver_weather[:daily][0]).to have_key(:dt)
      expect(denver_weather[:daily][0][:temp]).to have_key(:min)
      expect(denver_weather[:daily][0][:temp]).to have_key(:max)
      expect(denver_weather[:daily][0][:weather][0]).to have_key(:id)
      expect(denver_weather[:daily][0][:weather][0]).to have_key(:main)
      expect(denver_weather[:daily][0][:weather][0]).to have_key(:description)
      expect(denver_weather[:daily][0][:weather][0]).to have_key(:icon)

      expect(denver_weather[:hourly].length).to eq(48)
      expect(denver_weather[:hourly][0]).to have_key(:dt)
      expect(denver_weather[:hourly][0]).to have_key(:temp)
    end
  end

  it "can retrieve weather for Seattle (with rain/visibility)" do
    VCR.use_cassette("seattle weather") do
      latitude = 47.6062095
      longitude = -122.3320708

      seattle_weather = OpenWeatherServices.new.get_weather(latitude, longitude)

      expect(seattle_weather[:current]).to have_key(:dt)
      expect(seattle_weather[:current]).to have_key(:sunrise)
      expect(seattle_weather[:current]).to have_key(:sunset)
      expect(seattle_weather[:current]).to have_key(:temp)
      expect(seattle_weather[:current]).to have_key(:feels_like)
      expect(seattle_weather[:current]).to have_key(:humidity)
      expect(seattle_weather[:current]).to have_key(:uvi)
      expect(seattle_weather[:current]).to have_key(:visibility)
      expect(seattle_weather[:current][:weather][0]).to have_key(:id)
      expect(seattle_weather[:current][:weather][0]).to have_key(:main)
      expect(seattle_weather[:current][:weather][0]).to have_key(:description)
      expect(seattle_weather[:current][:weather][0]).to have_key(:icon)

      expect(seattle_weather[:daily].length).to eq(8)
      expect(seattle_weather[:daily][0]).to have_key(:dt)
      expect(seattle_weather[:daily][0]).to have_key(:rain)
      expect(seattle_weather[:daily][0][:temp]).to have_key(:min)
      expect(seattle_weather[:daily][0][:temp]).to have_key(:max)
      expect(seattle_weather[:daily][0][:weather][0]).to have_key(:id)
      expect(seattle_weather[:daily][0][:weather][0]).to have_key(:main)
      expect(seattle_weather[:daily][0][:weather][0]).to have_key(:description)
      expect(seattle_weather[:daily][0][:weather][0]).to have_key(:icon)

      expect(seattle_weather[:hourly].length).to eq(48)
      expect(seattle_weather[:hourly][0]).to have_key(:dt)
      expect(seattle_weather[:hourly][0]).to have_key(:temp)
    end
  end
end