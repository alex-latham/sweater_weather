module Api
  module V1
    class BackgroundController < ApplicationController
      def index
        location = Location.from_name(background_params[:location])
        background = Background.from_location(location)
        render json: BackgroundSerializer.new(background)
      end

      private

      def background_params
        params.permit(:location)
      end
    end
  end
end