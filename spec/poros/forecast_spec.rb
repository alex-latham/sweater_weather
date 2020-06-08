require 'rails_helper'

RSpec.describe Forecast do
  describe "class methods" do
    it "from_geocoding (without rain/visibility)" do
      VCR.use_cassette("denver forecast poro") do
        geocoding = Geocoding.from_location_name("denver,co")
        forecast  = Forecast.from_geocoding(geocoding)

        expect(forecast.id).to eq(0)
        expect(forecast.location).to eq("Denver, CO, USA")
        expect(forecast.current).to have_key(:dt)
        expect(forecast.current).to have_key(:sunrise)
        expect(forecast.current).to have_key(:sunset)
        expect(forecast.current).to have_key(:temp)
        expect(forecast.current).to have_key(:feels_like)
        expect(forecast.current).to have_key(:humidity)
        expect(forecast.current).to have_key(:uvi)
        expect(forecast.current[:weather][0]).to have_key(:id)
        expect(forecast.current[:weather][0]).to have_key(:main)
        expect(forecast.current[:weather][0]).to have_key(:description)
        expect(forecast.current[:weather][0]).to have_key(:icon)

        expect(forecast.hourly.length).to eq(48)
        expect(forecast.hourly[0]).to have_key(:dt)
        expect(forecast.hourly[0]).to have_key(:temp)

        expect(forecast.daily.length).to eq(8)
        expect(forecast.daily[0]).to have_key(:dt)
        expect(forecast.daily[0][:temp]).to have_key(:min)
        expect(forecast.daily[0][:temp]).to have_key(:max)
        expect(forecast.daily[0][:weather][0]).to have_key(:id)
        expect(forecast.daily[0][:weather][0]).to have_key(:main)
        expect(forecast.daily[0][:weather][0]).to have_key(:description)
        expect(forecast.daily[0][:weather][0]).to have_key(:icon)
      end
    end

    it "from_geocoding (with rain/visibility)" do
      VCR.use_cassette("seattle forecast poro") do
        geocoding = Geocoding.from_location_name("seattle,wa")
        forecast = Forecast.from_geocoding(geocoding)

        expect(forecast.current).to have_key(:dt)
        expect(forecast.current).to have_key(:sunrise)
        expect(forecast.current).to have_key(:sunset)
        expect(forecast.current).to have_key(:temp)
        expect(forecast.current).to have_key(:feels_like)
        expect(forecast.current).to have_key(:humidity)
        expect(forecast.current).to have_key(:uvi)
        expect(forecast.current).to have_key(:visibility)
        expect(forecast.current[:weather][0]).to have_key(:id)
        expect(forecast.current[:weather][0]).to have_key(:main)
        expect(forecast.current[:weather][0]).to have_key(:description)
        expect(forecast.current[:weather][0]).to have_key(:icon)

        expect(forecast.hourly.length).to eq(48)
        expect(forecast.hourly[0]).to have_key(:dt)
        expect(forecast.hourly[0]).to have_key(:temp)

        expect(forecast.daily.length).to eq(8)
        expect(forecast.daily[0]).to have_key(:dt)
        expect(forecast.daily[0]).to have_key(:rain)
        expect(forecast.daily[0][:temp]).to have_key(:min)
        expect(forecast.daily[0][:temp]).to have_key(:max)
        expect(forecast.daily[0][:weather][0]).to have_key(:id)
        expect(forecast.daily[0][:weather][0]).to have_key(:main)
        expect(forecast.daily[0][:weather][0]).to have_key(:description)
        expect(forecast.daily[0][:weather][0]).to have_key(:icon)
      end
    end
  end
end