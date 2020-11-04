class LandingController < ApplicationController
before_action :authenticate_user!

class LandingController < ApplicationController
  def index
    render json: { message: 'API ok!' }
  end
end
