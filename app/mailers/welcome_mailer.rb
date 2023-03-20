# frozen_string_literal: true

class WelcomeMailer < ApplicationMailer
  def send_email
    @email = params[:email]
    @full_name = params[:full_name]
    @redirect_url = 'https://app.doctour.com.mx'

    mail(to: @email, subject: 'Welcome to DocTour')
  end
end
