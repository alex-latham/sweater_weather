module Api
  module V1
    class UsersController < ApplicationController
      def create
        return unless user_params[:password] == user_params[:password_confirmation]
        user = User.new(
          email: user_params[:email],
          password: user_params[:password],
          api_key: SecureRandom.hex(24)
        )
        if user.save
          render json: UserSerializer.new(user)
        end
      end

      private

      def user_params
        params.permit(:email, :password, :password_confirmation)
      end
    end
  end
end