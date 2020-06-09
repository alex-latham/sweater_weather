module Api
  module V1
    class RoadTripController < ApplicationController
      def create
        user = User.find_by(api_key: road_trip_params[:api_key])
        origin = Location.by_name(road_trip_params[:origin])
        destination = Location.by_name(road_trip_params[:destination])
        road_trip = RoadTrip.new(user: user, origin: origin, destination: destination)
        if user.exists?
          render json: RoadTripSerializer.new(road_trip)
        else
        end
      end

      private

      def road_trip_params
        params.permit(:origin, :destination, :api_key)
      end
    end
  end
end
