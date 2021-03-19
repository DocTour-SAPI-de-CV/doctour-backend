class WelcomeMailerPreview < ActionMailer::Preview
  def send_email
    WelcomeMailer.with(user: User.first).send_email
  end
end