# frozen_string_literal: true

class PasswordRecoveryController < ApplicationController
  before_action :authenticate_user, only: [:recovery]

  include ErrorSerializer

  rescue_from ActionController::ParameterMissing, with: :missing_params

  def index
    user = User.find_by(email: email)
    PasswordMailerSender.send_email(user.email)

    head(:no_content)
  end

  def recovery
    @user = User.find(id)
    @user.update(password: new_password) if PasswordUpdateMailerSender.send_email(@user.email)
  end

  private

  def email
    params.require(:email)
  end

  def id
    params.require(:id)
  end

  def new_password
    params.require(:password)
  end
end
