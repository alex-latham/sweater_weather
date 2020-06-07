class Api::V1::ForecastsController < ApplicationController
  def show
    geocoding_json = GoogleMapsServices.new.get_geocoding(forecast_params[:location])
    latitude = geocoding_json[:results][0][:geometry][:location][:lat]
    longitude = geocoding_json[:results][0][:geometry][:location][:lng]
    weather_json = OpenWeatherServices.new.get_weather(latitude, longitude)

    location = geocoding_json[:results][0][:formatted_address]
    # current_weather =
    # daily_weather =
    # hourly_weather =
  end

  private

  def forecast_params
    params.permit(:location)
  end
end
