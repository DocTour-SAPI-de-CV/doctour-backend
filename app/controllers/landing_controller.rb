class LandingController < ApplicationController
before_action :authenticate_user!

  def index
    render json: { message: 'API ok!' }
  end
end
