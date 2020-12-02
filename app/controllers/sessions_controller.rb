# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  skip_before_action :authenticate_user
  respond_to :json

  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    token = Warden::JWTAuth::UserEncoder.new.call(resource, :user, nil)

    render json: { authorization: token[0] }
  end

  private

  def respond_with(resource, _opts = {})
    render json: resource
  end

  def respond_to_on_destroy
    head :no_content
  end
end
