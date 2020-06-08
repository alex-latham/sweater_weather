module Api
  module V1
    class FoodieController < ApplicationController
      def index
        foodie = Foodie.search(foodie_params)
        binding.pry
        render json: FoodieSerializer.new(foodie)
      end

      private

      def foodie_params
        params.permit(:start, :end, :search)
      end
    end
  end
end
