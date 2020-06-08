require 'rails_helper'

RSpec.describe GoogleMapsServices do
  it 'can retrieve geocoding for Denver' do
    VCR.use_cassette('denver geocoding json') do
      location = 'denver,co'
      geocoding_json = GoogleMapsServices.new.get_geocoding(location)

      expect(geocoding_json[:status]).to eq('OK')
      expect(geocoding_json[:results][0]).to have_key(:formatted_address)
      expect(geocoding_json[:results][0][:geometry][:location]).to have_key(:lat)
      expect(geocoding_json[:results][0][:geometry][:location]).to have_key(:lng)
    end
  end
end
