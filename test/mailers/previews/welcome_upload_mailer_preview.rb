
class WelcomeUploadMailerPreview < ActionMailer::Preview
  def send_email
    WelcomeUploadMailer.with(user: User.first).send_email
  end
end
