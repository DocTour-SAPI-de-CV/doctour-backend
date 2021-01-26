# frozen_string_literal: true

VERIFY = Register::VerificationController

module Register
  class ShowController < ApplicationController
    def account
      user = User.find(params[:id])

      render json: user.as_json
    end
  end
end
