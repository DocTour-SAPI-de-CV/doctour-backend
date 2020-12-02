# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'doctor@gmail.com'
  layout 'mailer'
end
