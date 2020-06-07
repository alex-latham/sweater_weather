require 'rails_helper'

RSpec.describe GoogleMapsServices do
  it "can retrieve geocoding for an American city" do
    VCR.use_cassette("denver geocoding") do
      location = "denver,co"
      denver_geocoding = GoogleMapsServices.new.get_geocoding(location)

      expect(denver_geocoding[:status]).to eq("OK")
      expect(denver_geocoding[:results][0][:formatted_address]).to eq("Denver, CO, USA")
      expect(denver_geocoding[:results][0][:geometry][:location]).to eq({ lat: 39.7392358, lng: -104.990251 })
    end
  end

  it "can retrieve geocoding for a Belgian city" do
    VCR.use_cassette("brussels geocoding") do
      location = "brussels,be"
      brussels_geocoding = GoogleMapsServices.new.get_geocoding(location)

      expect(brussels_geocoding[:status]).to eq("OK")
      expect(brussels_geocoding[:results][0][:formatted_address]).to eq("Brussels, Belgium")
      expect(brussels_geocoding[:results][0][:geometry][:location]).to eq({ lat: 50.8503396, lng: 4.3517103 })
    end
  end
end