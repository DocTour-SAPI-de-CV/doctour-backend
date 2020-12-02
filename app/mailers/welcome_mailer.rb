# frozen_string_literal: true

class WelcomeMailer < ApplicationMailer
  RECOVERY_REDIRECT_URL = Rails.application.credentials.mailer[:redirect_url]

  def send_email
    @email = params[:email]
    @full_name = params[:full_name]
    @recovery_url = RECOVERY_REDIRECT_URL

    mail(to: @email, subject: 'Welcome to DocTour')
  end
end
