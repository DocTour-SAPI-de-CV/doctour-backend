# frozen_string_literal: true

class PasswordUpdateMailerSender
  def self.send_email(email)
    populate_user(email)
    id = @user.id
    email = @user.email

    PasswordUpdateMailer.with(email: email,
                                id: id)
                          .password_update
                          .deliver_later
  end

  private_class_method def self.populate_user(email)
    @user = User.find_by(email: email)
  end
end
