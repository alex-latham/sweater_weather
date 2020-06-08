module Api
  module V1
    class ForecastController < ApplicationController
      def index
        geocoding = Geocoding.from_location_name(forecast_params[:location])
        forecast = Forecast.from_geocoding(geocoding)
        render json: ForecastSerializer.new(forecast)
      end

      private

      def forecast_params
        params.permit(:location)
      end
    end
  end
end
