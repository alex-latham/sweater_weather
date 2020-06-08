require 'rails_helper'

RSpec.describe "Client", type: :request do
  it "can request forecast for a city" do
    VCR.use_cassette("denver forecast request") do
      get api_v1_forecast_path(params: { location: "denver,co" })

      expect(response).to be_successful
    end
  end
end