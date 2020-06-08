require 'rails_helper'

RSpec.describe Geocoding do
  describe "class methods" do
    it "from_location_name" do
      VCR.use_cassette("denver geocoding poro") do
        geocoding = Geocoding.from_location_name("denver,co")

        expect(geocoding.class).to eq(Geocoding)
        expect(geocoding.formatted_address).to eq("Denver, CO, USA")
        expect(geocoding.latitude).to eq(39.7392358)
        expect(geocoding.longitude).to eq(-104.990251)
      end
    end
  end
end