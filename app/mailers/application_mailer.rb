# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'doctour@doctour.com'
  layout 'mailer'
end
