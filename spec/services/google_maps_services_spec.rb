require 'rails_helper'

RSpec.describe GoogleMapsServices do
  it "can retrieve geocoding for Denver" do
    VCR.use_cassette("denver geocoding") do
      location = "denver,co"

      geocoding_json = GoogleMapsServices.new.get_geocoding(location)

      expect(geocoding_json[:status]).to eq("OK")
      expect(geocoding_json[:results][0][:formatted_address]).to eq("Denver, CO, USA")
      expect(geocoding_json[:results][0][:geometry][:location]).to eq({ lat: 39.7392358, lng: -104.990251 })
    end
  end

  it "can retrieve geocoding for Brussels" do
    VCR.use_cassette("brussels geocoding") do
      location = "brussels,be"

      geocoding_json = GoogleMapsServices.new.get_geocoding(location)

      expect(geocoding_json[:status]).to eq("OK")
      expect(geocoding_json[:results][0][:formatted_address]).to eq("Brussels, Belgium")
      expect(geocoding_json[:results][0][:geometry][:location]).to eq({ lat: 50.8503396, lng: 4.3517103 })
    end
  end
end