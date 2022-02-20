# frozen_string_literal: true

class PasswordUpdateMailer < ApplicationMailer
  # RECOVERY_REDIRECT_URL = Rails.application.credentials.mailer[:redirect_url]
  RECOVERY_REDIRECT_URL = 'https://doctour-staging.netlify.com/sign_in'
  # RECOVERY_REDIRECT_URL = 'http://192.168.8.94:8080/sign_in'

  def password_update
    @email = params[:email]
    @id = params[:id]
    @full_name = People.find_by(
      account: Account.find_by(
        user_id: User.find(@id).id
      )
    ).full_name
    @recovery_url = password_recovery_url

    mail(to: @email, subject: 'Password update')
  end

  def password_recovery_url
    RECOVERY_REDIRECT_URL
  end
end
