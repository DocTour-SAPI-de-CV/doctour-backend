# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'christopherpottesc@gmail.com'
  layout 'bootstrap-mailer'
end
