require 'rails_helper'

RSpec.describe OpenWeatherServices do
  it 'can retrieve weather json for a city' do
    VCR.use_cassette('forecast portland') do
      location = Location.search('portland,or')
      json = OpenWeatherServices.new.get_forecast(location)

      expect(json[:current][:dt]).to eq(1591659238)
      expect(json[:current][:sunrise]).to eq(1591618941)
      expect(json[:current][:sunset]).to eq(1591675063)
      expect(json[:current][:temp]).to eq(63.1)
      expect(json[:current][:feels_like]).to eq(59.22)
      expect(json[:current][:humidity]).to eq(51)
      expect(json[:current][:uvi]).to eq(7.41)
      expect(json[:current][:visibility]).to eq(16093)
      expect(json[:current][:weather][0][:description]).to eq('overcast clouds')
      expect(json[:current][:weather][0][:icon]).to eq('04d')

      expect(json[:hourly].length).to eq(48)
      json[:hourly].each do |hour|
        expect(hour[:dt]).to be_between(1591657200, 1591826400)
        expect(hour[:weather][0][:icon]).to be_a(String)
        expect(hour[:weather][0][:icon].chars.length).to eq(3)
        expect(hour[:temp]).to be_between(52, 76.69)
      end

      expect(json[:daily].length).to eq(8)
      json[:daily].each do |day|
        expect(day[:dt]).to be_between(1591646400, 1592251200)
        expect(day[:weather][0][:icon]).to be_a(String)
        expect(day[:weather][0][:icon].chars.length).to eq(3)
        expect(day[:weather][0][:main]).to be_a(String)
        expect(day[:rain]).to be_between(0.27, 19.48)
        expect(day[:temp][:max]).to be_between(57.96, 76.66)
        expect(day[:temp][:min]).to be_between(50.85, 59.09)
      end
    end
  end
end
