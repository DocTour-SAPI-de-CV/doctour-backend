# frozen_string_literal: true

class WelcomeUploadMailer < ApplicationMailer
  def welcome_upload
    @email = params[:email]
    @full_name = params[:full_name]
    @redirect_url = 'https://doctour-staging.netlify.com'

    mail(to: @email, subject: 'Welcome to DocTour')
  end
end
