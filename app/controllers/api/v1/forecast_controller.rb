module Api
  module V1
    class ForecastController < ApplicationController
      def index
        location = Location.from_name(forecast_params[:location])
        forecast = Forecast.at_location(location)
        render json: ForecastSerializer.new(forecast)
      end

      private

      def forecast_params
        params.permit(:location)
      end
    end
  end
end
