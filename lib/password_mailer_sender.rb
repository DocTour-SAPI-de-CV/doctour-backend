# frozen_string_literal: true

class PasswordMailerSender
  def self.send_email(email)
    populate_user(email)
    id = @user.id
    email = @user.email
    token = generate_token

    PasswordRecoveryMailer.with(email: email,
                                token: token,
                                id: id)
                          .password_recovery
                          .deliver
  end

  private_class_method def self.populate_user(email)
    @user = User.find_by(email: email)
  end

  private_class_method def self.generate_token
    Warden::JWTAuth::UserEncoder.new.call(@user, :user, nil).first
  end
end
