class WelcomeMailerV2Preview < ActionMailer::Preview
  def greet
    WelcomeMailerV2.with(user: User.first).greet
  end
end