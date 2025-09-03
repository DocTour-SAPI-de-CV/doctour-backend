# frozen_string_literal: true  
  
class PasswordRecoveryController < ApplicationController  
  include ErrorSerializer  
  
  rescue_from ActionController::ParameterMissing, with: :missing_params  
  
  def index  
    user = User.find_by(email: email)  
      
    if user  
      # Generate secure reset token  
      token = user.send_reset_password_instructions  
      PasswordMailerSender.send_email(user.email, token, user.id)
    end  
  
    # Always return success to prevent email enumeration  
    head(:no_content)  
  end  
  
  def recovery  
    user = User.reset_password_by_token(  
      reset_password_token: reset_token,  
      password: new_password,  
      password_confirmation: new_password  
    )  
  
    if user.errors.empty?  
      PasswordUpdateMailerSender.send_email(user.email)  
      render json: { message: 'Password updated successfully!' }  
    else  
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity  
    end  
  end  
  
  private  
  
  def email  
    params.require(:email)  
  end  
  
  def reset_token  
    params.require(:reset_password_token)  
  end  
  
  def new_password  
    params.require(:password)  
  end  
end
