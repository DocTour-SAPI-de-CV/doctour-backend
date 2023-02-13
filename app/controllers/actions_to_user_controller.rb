# frozen_string_literal: true

class ActionsToUserController < ApplicationControllerJsonApi
  include ErrorSerializer

  # rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { actions_to_user: ActionsToUser.all })
  end

  def index
    render(json: { actions_to_user: ActionsToUser.find(params[:id]) })
  end

  def create
    action = ActionsToUser.new(actions_to_user_params)
    if action.save

      if action[:description] == 'new_screening'
        ScreeningChannel.broadcast_to 'new_screening', screening_id: 1
      end

      render(json: { actions_to_user: action })
    end

    render(json: { error: action.errors }) unless action.save
  end

  def delete
    @action = ActionsToUser.find(params[:id])
    @action.destroy!
    render(json: { "action_id deleted": params[:id] })
  end

  def update
    action = ActionsToUser.find(params[:id])
    render(json: { actions_to_user: action }) if action.update(actions_to_user_params)

    render(json: { error: action.errors }) unless action.update(actions_to_user_params)
  end

  private

  def actions_to_user_params
    params.require(:actions_to_user).permit(:description, :user_id)
  end
end
