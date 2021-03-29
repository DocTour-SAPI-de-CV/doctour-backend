class FeedbacksController < ApplicationControllerJsonApi
  skip_before_action :authenticate_user, only: [:create]
end
