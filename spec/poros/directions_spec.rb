require 'rails_helper'

RSpec.describe Directions do
  describe 'class methods' do
    it 'search' do
      origin = 'denver,co'
      destination = 'pueblo,co'

      directions = Directions.search(origin, destination)

      expect(directions.travel_time).to be_a(String)
    end
  end
end