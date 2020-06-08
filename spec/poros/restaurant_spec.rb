require 'rails_helper'

RSpec.describe Restaurant do
  describe 'class methods' do
    it 'by_geocoding_and_cuisines' do
      geocoding = Geocoding.from_location_name('pueblo,co')
      cuisines = 'italian'

      restaurant = Restaurant.by_geocoding_and_cuisines(geocoding, cuisines)

      expect(restaurant.name).to be_a(String)
      expect(restaurant.address).to be_a(String)
      expect(restaurant.address).to include('Pueblo')
    end
  end
end