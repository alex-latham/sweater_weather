require 'rails_helper'

RSpec.describe Foodie do
  describe 'class methods' do
    it 'search' do
      foodie_params = {
        start: 'denver,co',
        end: 'pueblo,co',
        search: 'italian'
      }

      foodie = Foodie.search(foodie_params)

      expect(foodie.id).to be_nil
      expect(foodie.end_location).to eq('pueblo,co')
      expect(foodie.travel_time).to be_a(String)
      expect(foodie.forecast).to have_key(:summary)
      expect(foodie.forecast).to have_key(:temperature)
      expect(foodie.forecast.length).to eq(2)
      expect(foodie.forecast[:summary]).to be_a(String)
      expect(foodie.forecast[:temperature]).to be_a(Float)
      expect(foodie.restaurant).to have_key(:name)
      expect(foodie.restaurant).to have_key(:address)
      expect(foodie.restaurant.length).to eq(2)
      expect(foodie.restaurant[:address]).to be_a(String)
      expect(foodie.restaurant[:address]).to be_a(String)
    end
  end
end