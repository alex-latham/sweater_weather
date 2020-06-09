require 'rails_helper'

RSpec.describe GoogleMapsServices do
  it 'can retrieve location json for a city' do
    VCR.use_cassette('denver geocoding json') do
      location_json = GoogleMapsServices.new.get_location('denver,co')

      expect(location_json[:status]).to eq('OK')
      expect(location_json[:results][0]).to have_key(:formatted_address)
      expect(location_json[:results][0][:geometry][:location]).to have_key(:lat)
      expect(location_json[:results][0][:geometry][:location]).to have_key(:lng)
    end
  end
end
