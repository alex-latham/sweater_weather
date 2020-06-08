module Api
  module V1
    class FoodieController < ApplicationController
      def index
        foodie = Foodie.from_geocoding(geocoding)
        render json: FoodieSerializer.new(foodie)
      end

      private

      def forecast_params
        params.permit(:location)
      end
    end
  end
end
