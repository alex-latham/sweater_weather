module Api
  module V1
    class SessionsController < ApplicationController
      def create
        user = User.find_by(email: params[:email])
        if user.authenticate(params[:password])
          render json: UserSerializer.new(user)
        end
      end

      private

      def session_params
        params.permit(:email, :password)
      end
    end
  end
end