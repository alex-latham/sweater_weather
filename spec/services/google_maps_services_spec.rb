require 'rails_helper'

RSpec.describe "Visitor" do
  it "can retrieve coordinates for an American city" do
    VCR.use_cassette("denver geocode") do
      location = "denver,co"
      json = GoogleMapsServices.new.get_coordinates(location)

      expect(json[:status]).to eq("OK")
      expect(json[:results][0][:formatted_address]).to eq("Denver, CO, USA")
      expect(json[:results][0][:geometry][:location]).to eq({ lat: 39.7392358, lng: -104.990251 })
    end
  end

  it "can retrieve coordinates for a Belgian city" do
    VCR.use_cassette("brussels geocode") do
      location = "brussels,be"
      json = GoogleMapsServices.new.get_coordinates(location)

      expect(json[:status]).to eq("OK")
      expect(json[:results][0][:formatted_address]).to eq("Brussels, Belgium")
      expect(json[:results][0][:geometry][:location]).to eq({ lat: 50.8503396, lng: 4.3517103 })
    end
  end
end