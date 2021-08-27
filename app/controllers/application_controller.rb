# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate_user

  def user
    people = People.find_by(account_id: Account.find_by(user_id: @current_user.id))
    @user = if people.nil?
        {
                id: @current_user.id,
                email: @current_user.email,
                jti: @current_user.jti,
              }
      else
        {
                id: @current_user.id,
                email: @current_user.email,
                jti: @current_user.jti,
                first_name: people.first_name,
                last_name: people.last_name,
                initials: people.first_name[0] + people.last_name.split(" ").last[0],
                gender: people.gender,
                category: people.account.category,
              }
      end
    render json: @user
  end

  def admin_authorization
    category = Account.find_by(user_id: current_user.id).category
    unauthorized("admin") if category != "admin" && category != "master"
  end

  def master_authorization
    unless Account.find_by(user_id: current_user.id).category == "master"
      unauthorized("master")
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:cpf])
  end

  def authenticate_user
    auth = request.headers["Authorization"] || request.cookies["auth._token.local"]
    
    return unauthorized("user") if auth.blank?

    token = auth.split.last

    begin
      jwt_payload = JWT.decode(token, Rails.application.credentials.devise_jwt_secret)
      @current_user = User.find_by(jti: jwt_payload[0]["jti"])

      @current_user
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
      unauthorized("user")
    end
  end

  def unauthorized(type)
    render json: { Gandalf_says: "You shall not pass! (only #{type}s)" }, status: :unauthorized
  end

  def authenticate_user!(_options = {})
    head :unauthorized unless signed_in?
  end

  def current_user
    @current_user ||= super || User.find(@current_user_id)
  end

  def signed_in?
    @current_user_id.present?
  end
end
