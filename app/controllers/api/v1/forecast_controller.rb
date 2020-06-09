module Api
  module V1
    class ForecastController < ApplicationController
      def index
        forecast = Forecast.search(forecast_params[:location])
        render json: ForecastSerializer.new(forecast)
      end

      private

      def forecast_params
        params.permit(:location)
      end
    end
  end
end
