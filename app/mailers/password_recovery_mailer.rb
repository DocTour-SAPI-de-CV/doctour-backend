# frozen_string_literal: true

class PasswordRecoveryMailer < ApplicationMailer
  # RECOVERY_REDIRECT_URL = Rails.application.credentials.mailer[:redirect_url]
  RECOVERY_REDIRECT_URL = 'https://app.doctour.com.mx/recovery_password'
  # RECOVERY_REDIRECT_URL = 'http://192.168.8.94:8080/recovery_password'

  def password_recovery
    @email = params[:email]
    @token = params[:token]
    @id = params[:id]
    @full_name = People.find_by(account: Account.find_by(user_id: @id))&.full_name  
    @recovery_url = password_recovery_url(@token, @id)

    mail(to: @email, subject: 'Password Recover')
  end

  private 

  def password_recovery_url(token, id)
    "#{RECOVERY_REDIRECT_URL}?reset_password_token=#{token}&id=#{id}"
  end
end
