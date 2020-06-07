require 'rails_helper'

RSpec.describe "Visitors", type: :request do
  it "can request forecast for a city" do
    get api_v1_forecast_path(params: { location: "denver,co" })

    expect(response).to be_successful
  end
end