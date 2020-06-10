module Api
  module V1
    class SessionsController < ApplicationController
      def create
        user = User.find_by(email: session_params[:email])
        if user.present? && user.authenticate(session_params[:password])
          render json: UserSerializer.new(user)
        else
          error = 'Bad email/password combination'
          render json: { error: error }, status: :unauthorized
        end
      end

      private

      def session_params
        params.permit(:email, :password)
      end
    end
  end
end