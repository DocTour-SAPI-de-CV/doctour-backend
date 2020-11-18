# frozen_string_literal: true

class AccountController < ApplicationController
  include ErrorSerializer

  rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { accounts: Account.all })
  end

  def index
    render(json: { account: Account.find(params[:id]) })
  end

  def create
    account = Account.new(account_params)
    render(json: { account: account }) if account.save

    render(json: { error: account.errors }) unless account.save
  end

  def delete
    @account = Account.find(params[:id])
    @account.destroy!

    render(json: { "account_id deleted": params[:id] })
  end

  def update
    account = Account.find(params[:id])
    render(json: { account: account }) if account.update(account_params)

    render(json: { error: account.errors }) unless account.update(account_params)
  end

  private

  def account_params
    params.require(:account).permit(:category, :user_id)
  end
end
