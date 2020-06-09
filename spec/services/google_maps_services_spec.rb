require 'rails_helper'

RSpec.describe GoogleMapsServices do
  it 'can retrieve location json for denver' do
    VCR.use_cassette('denver location json') do
      location_json = GoogleMapsServices.new.get_location('denver,co')

      expect(location_json[:status]).to eq('OK')
      expect(location_json[:results][0][:address_components][0][:short_name]).to eq('Denver')
      expect(location_json[:results][0][:address_components][0][:types]).to eq(['locality', 'political'])
      expect(location_json[:results][0][:address_components][2][:short_name]).to eq('CO')
      expect(location_json[:results][0][:address_components][2][:types]).to eq(['administrative_area_level_1', 'political'])
      expect(location_json[:results][0][:address_components][3][:long_name]).to eq('United States')
      expect(location_json[:results][0][:address_components][3][:types]).to eq(['country', 'political'])
      expect(location_json[:results][0][:formatted_address]).to eq('Denver, CO, USA')
      expect(location_json[:results][0][:geometry][:location][:lat]).to eq(39.7392358)
      expect(location_json[:results][0][:geometry][:location][:lng]).to eq(-104.990251)
    end
  end

  it 'can retrieve location json for paris' do
    VCR.use_cassette('paris location json') do
      location_json = GoogleMapsServices.new.get_location('paris,fr')

      expect(location_json[:status]).to eq('OK')
      expect(location_json[:results][0][:address_components][0][:short_name]).to eq('Paris')
      expect(location_json[:results][0][:address_components][0][:types]).to eq(['locality', 'political'])
      expect(location_json[:results][0][:address_components][2][:short_name]).to eq('IDF')
      expect(location_json[:results][0][:address_components][2][:types]).to eq(['administrative_area_level_1', 'political'])
      expect(location_json[:results][0][:address_components][3][:long_name]).to eq('France')
      expect(location_json[:results][0][:address_components][3][:types]).to eq(['country', 'political'])
      expect(location_json[:results][0][:formatted_address]).to eq('Paris, France')
      expect(location_json[:results][0][:geometry][:location][:lat]).to eq(48.856614)
      expect(location_json[:results][0][:geometry][:location][:lng]).to eq(2.3522219)
    end
  end

  it 'can retrieve location json for shinjuku' do
    VCR.use_cassette('shinjuku location json') do
      location_json = GoogleMapsServices.new.get_location('shinjuku,jp')

      expect(location_json[:status]).to eq('OK')
      expect(location_json[:results][0][:address_components][0][:short_name]).to eq('Shinjuku City')
      expect(location_json[:results][0][:address_components][0][:types]).to eq(['locality', 'political'])
      expect(location_json[:results][0][:address_components][1][:short_name]).to eq('Tokyo')
      expect(location_json[:results][0][:address_components][1][:types]).to eq(['administrative_area_level_1', 'political'])
      expect(location_json[:results][0][:address_components][2][:long_name]).to eq('Japan')
      expect(location_json[:results][0][:address_components][2][:types]).to eq(['country', 'political'])
      expect(location_json[:results][0][:formatted_address]).to eq('Shinjuku City, Tokyo, Japan')
      expect(location_json[:results][0][:geometry][:location][:lat]).to eq(35.6938253)
      expect(location_json[:results][0][:geometry][:location][:lng]).to eq(139.7033559)
    end
  end

  it 'can retrieve location json for cairns' do
    VCR.use_cassette('cairns location json') do
      location_json = GoogleMapsServices.new.get_location('cairns,au')

      expect(location_json[:status]).to eq('OK')
      expect(location_json[:results][0][:address_components][0][:short_name]).to eq('Cairns')
      expect(location_json[:results][0][:address_components][0][:types]).to eq(['colloquial_area', 'locality', 'political'])
      expect(location_json[:results][0][:address_components][2][:short_name]).to eq('QLD')
      expect(location_json[:results][0][:address_components][2][:types]).to eq(['administrative_area_level_1', 'political'])
      expect(location_json[:results][0][:address_components][3][:long_name]).to eq('Australia')
      expect(location_json[:results][0][:address_components][3][:types]).to eq(['country', 'political'])
      expect(location_json[:results][0][:formatted_address]).to eq('Cairns QLD, Australia')
      expect(location_json[:results][0][:geometry][:location][:lat]).to eq(-16.9185514)
      expect(location_json[:results][0][:geometry][:location][:lng]).to eq(145.7780548)
    end
  end

  it 'can retrieve location json for washington d.c.' do
    VCR.use_cassette('washington d.c. location json') do
      location_json = GoogleMapsServices.new.get_location('dc,dc')

      expect(location_json[:status]).to eq('OK')
      expect(location_json[:results][0][:address_components][0][:short_name]).to eq('Washington')
      expect(location_json[:results][0][:address_components][0][:types]).to eq(['locality', 'political'])
      expect(location_json[:results][0][:address_components][2][:short_name]).to eq('DC')
      expect(location_json[:results][0][:address_components][2][:types]).to eq(['administrative_area_level_1', 'political'])
      expect(location_json[:results][0][:address_components][3][:long_name]).to eq('United States')
      expect(location_json[:results][0][:address_components][3][:types]).to eq(['country', 'political'])
      expect(location_json[:results][0][:formatted_address]).to eq('Washington, DC, USA')
      expect(location_json[:results][0][:geometry][:location][:lat]).to eq(38.9071923)
      expect(location_json[:results][0][:geometry][:location][:lng]).to eq(-77.0368707)
    end
  end
end
