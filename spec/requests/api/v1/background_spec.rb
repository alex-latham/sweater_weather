require 'rails_helper'

RSpec.describe 'Client' do
  it 'can get get an image url for a location' do
    VCR.use_cassette('background denver') do
      get api_v1_background_path(params: { location: 'denver,co' })

      expected_url = 'https://images.unsplash.com/photo-1578983427937-26078ee3d9d3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjE0MDkwMX0'

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(json[:data]).to have_key(:id)
      expect(json[:data][:id]).to be_nil
      expect(json[:data][:type]).to eq('background')
      expect(json[:data][:links][:url]).to eq(expected_url)
      expect(json[:data].length).to eq(3)
      expect(json[:data][:links].length).to eq(1)
    end
  end
end