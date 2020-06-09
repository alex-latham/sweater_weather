module Api
  module V1
    class UsersController < ApplicationController
      def create
        user = User.new(
          email: user_params[:email],
          password: user_params[:password],
          password_confirmation: user_params[:password_confirmation],
          api_key: SecureRandom.hex(24)
        )
        if user.save
          render json: UserSerializer.new(user), status: :created
        else
          render json: UserSerializer.new(user), status: :bad_request
        end
      end

      private

      def user_params
        params.permit(:email, :password, :password_confirmation)
      end
    end
  end
end