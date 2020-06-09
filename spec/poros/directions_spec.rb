require 'rails_helper'

RSpec.describe Directions do
  describe 'class methods' do
    it 'with_origin_destination' do
      origin = 'denver,co'
      destination = 'pueblo,co'

      directions = Directions.with_origin_destination(origin, destination)

      expect(directions.travel_time).to be_a(String)
    end
  end
end