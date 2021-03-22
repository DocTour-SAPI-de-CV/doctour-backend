# frozen_string_literal: true

class DoctourMailer < ApplicationMailer
  before_action :get_params

  def greet
    make_bootstrap_mail(
      to: @email,
      from: "no-reply@doctour.com",
      subject: "Bem-vindo ao Doctour",
    ) do |format|
      format.html
      # format.text
    end
  end

  def attachment_added
    make_bootstrap_mail(
      to: @email,
      from: "no-reply@doctour.com",
      subject: "Documento anexado ao Doctour",
    ) do |format|
      format.html
      # format.text
    end
  end

  def password_changed
    make_bootstrap_mail(
      to: @email,
      from: "no-reply@doctour.com",
      subject: "Senha alterada com sucesso",
    ) do |format|
      format.html
      # format.text
    end
  end

  def password_recovery
    make_bootstrap_mail(
      to: @email,
      from: "no-reply@doctour.com",
      subject: "Recuperação de senha",
    ) do |format|
      format.html
      # format.text
    end
  end

  def password_register
    make_bootstrap_mail(
      to: @email,
      from: "no-reply@doctour.com",
      subject: "Bem-vindo ao Doctour",
    ) do |format|
      format.html
      # format.text
    end
  end

  private

  def get_params
    @user = params[:user]
    @full_name = @user.account.people.full_name
    @email = @user.email
  end
end
