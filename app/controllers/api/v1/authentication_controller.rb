require 'net/http'

module Api
  module V1
    
    class Api::V1::AuthenticationController < ApplicationController
        
      rescue_from ActionController::ParameterMissing, with: :parameter_missing
      rescue_from AuthenticationError, with: :handle_unathenticated

      def create  
        # p params.require(:password).inspect
        user = User.find_by(username: params.require(:username))
        raise AuthenticationError unless user.authenticate(params.require(:password))
        token = AuthenticationTokenService.call(user.id)

        # p params.inspect 
        render json: { token: '123' }, status: :created
      end

      private

      def user
        @user ||= User.find_by(username: params.required(:username))
      end

      def parameter_missing(e)
        render json: {
            error: e.message
        },
        status: :unproccessable_entity
      end
      
      def handle_unathenticated
        head::unauthorized
      end
      
    end
  end
end
