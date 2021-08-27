# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    protected

    def find_verified_user # this checks whether a user is authenticated with devise
      unless request.params[:token] || request.headers.key?("Authorization") && request.headers["Authorization"].split(" ").size > 1
        reject_unauthorized_connection
      end

      Rails.logger.info "alouu"
      token = request.params[:token] || request.headers["Authorization"].split(" ")[1]
      jwt = JWT.decode(token, Rails.application.credentials.devise_jwt_secret, true, algorithm: "HS256", verify_jti: true)[0]
      if (user = User.find(jwt["sub"]))
        user
      else
        reject_unauthorized_connection
      end
    end
  end
end
