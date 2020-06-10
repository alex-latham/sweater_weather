module Api
  module V1
    class RoadTripController < ApplicationController
      def create
        user = User.find_by(api_key: road_trip_params[:api_key])
        return unless user.present?

        road_trip = RoadTrip.plan(road_trip_params)
        render json: RoadTripSerializer.new(road_trip)
      end

      private

      def road_trip_params
        params.permit(:origin, :destination, :api_key)
      end
    end
  end
end
