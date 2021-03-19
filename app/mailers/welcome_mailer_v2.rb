# frozen_string_literal: true

class WelcomeMailerV2 < ApplicationMailer
  def greet
     make_bootstrap_mail(
      to: 'to@example.com',
      from: 'from@example.com',
      subject: 'Hi From Bootstrap Email',
      ) do |format|
        format.html 
       # format.text 
      end
  end
end
