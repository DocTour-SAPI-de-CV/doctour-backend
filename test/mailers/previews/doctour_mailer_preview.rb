class DoctourMailerPreview < ActionMailer::Preview
  def greet
    DoctourMailer.with(user: User.first).greet
  end

  def password_changed
    DoctourMailer.with(user: User.first).password_changed
  end

  def password_recovery
    DoctourMailer.with(user: User.first).password_recovery
  end

  def password_register
    DoctourMailer.with(user: User.first).password_register
  end

  def attachment_added
    DoctourMailer.with(user: User.first).attachment_added
  end
end
