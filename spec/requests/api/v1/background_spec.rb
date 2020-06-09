require 'rails_helper'

RSpec.describe 'Client' do
  it 'can get get an image for a location' do
    VCR.use_cassette('denver background request') do

      get api_v1_background_path(params: { location: 'denver,co' })

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data]).to have_key(:id)
      expect(json[:data][:id]).to be_nil
      expect(json[:data]).to have_key(:type)
      expect(json[:data][:type]).to eq('background')
      expect(json[:data][:attributes]).to have_key(:url)
      expect(json[:data][:attributes][:url]).to eq('https://images.unsplash.com/photo-1578983427937-26078ee3d9d3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjE0MDkwMX0')
    end
  end
end