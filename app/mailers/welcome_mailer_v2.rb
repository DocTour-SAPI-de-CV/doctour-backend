# frozen_string_literal: true

class WelcomeMailerV2 < ApplicationMailer
  def greet
    @user = params[:user]
    @full_name = @user.account.people.full_name
    @email = @user.email
    make_bootstrap_mail(
      to: @email,
      from: 'no-reply@doctour.com',
      subject: 'Bem-vindo ao Doctour',
      ) do |format|
        format.html 
       # format.text 
      end
  end
end
