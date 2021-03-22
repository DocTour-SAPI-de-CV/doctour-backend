class DoctourMailerPreview < ActionMailer::Preview
  def greet
    DoctourMailer.with(user: User.first).greet
  end
end