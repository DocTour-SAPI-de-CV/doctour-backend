class UserRequestController < ApplicationController
  include ErrorSerializer

  rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { user_request: UserRequests.all })
  end

  def create
    Rails.logger.info "testeeeeeeeeeeeeeeeeee"
    user_request = UserRequests.new(user_request_params)

    Rails.logger.info "CCCCCCCCCCCCCCCCCCCC"
    Rails.logger.info user_request.to_json
    if user_request.save
      render(json: { user_request: user_request })
      Rails.logger.info "BBBBBBBBB"
      ScreeningChannel.broadcast_to 'new_screening', screening_id: 1
    else
      render(json: { error: user_request.errors })
      Rails.logger.info "AAAAAAAAAAAAAAAAA"
    end
  end

  private

  def user_request_params
    params.require(:user_request).permit(:description, :user_id)
  end
end


