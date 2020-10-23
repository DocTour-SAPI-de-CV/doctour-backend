class LandingController < ApplicationController

  def index
    render json: { message: 'API ok!' }
  end

end
