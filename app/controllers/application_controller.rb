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
    
    # Validate token format  
    token_parts = auth.split  
    return unauthorized("user") if token_parts.length != 2 || token_parts.first.downcase != "bearer"  
    
    token = token_parts.last  
    return unauthorized("user") if token.blank?  
    
    begin  
      # Ensure JWT secret is properly configured  
      jwt_secret = Rails.application.credentials.devise_jwt_secret || ENV.fetch('DEVISE_JWT_SECRET_KEY')  
      return unauthorized("user") if jwt_secret.blank?   
      
      # Validate JWT payload structure  
      return unauthorized("user") if jwt_payload.blank? || jwt_payload[0].blank?  
      return unauthorized("user") unless jwt_payload[0].key?("jti")  
      
      jti = jwt_payload[0]["jti"]  
      return unauthorized("user") if jti.blank?  
      
      # Find user and validate existence  
      @current_user = User.find_by(jti: jti)  
      return unauthorized("user") if @current_user.nil?  
      
      @current_user  
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError => e  
      Rails.logger.warn "JWT authentication failed: #{e.message}"  
      unauthorized("user")  
    rescue StandardError => e  
      Rails.logger.error "Unexpected error in authentication: #{e.message}"  
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
