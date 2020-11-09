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
    if params[:category].nil?
      without_fields_error
    elsif !check_category(params[:category])
      render(json: {
               Error: 'category must be admin, cliente, doctor or assistant'
             })
    else
      create_account(params[:category])
    end
  end

  def delete
    @account = Account.find(params[:id])
    @account.destroy!
    render(json: { "account_id deleted": params[:id] })
  end

  def update
    if params[:category].nil?
      without_fields_error
    elsif !check_category(params[:category])
      render(json: {
               Error: 'category must be admin, cliente, doctor or assistant'
             })
    else
      @account = Account.find(params[:id])
      update_category(params[:category])
    end
  end

  private

  def check_category(category)
    true if %w[admin client docter assistant].include? category.downcase
  end

  def create_account(category)
    @account = Account.create(
      category: category
    )
    @account.save!
    render(json: { "account_id created": @account.id })
  end

  def without_fields_error
    render(json: { Erro: 'Field category is required!' },
           status: :unprocessable_entity)
  end

  def update_category(category)
    if !@account.nil?
      @account.update(category: category)
      @account.save!
      render(json: { "account_id updated": params[:id] })
    else
      render(json: { Error: 'Invalid ID, unable to update the account!' },
             status: :unprocessable_entity)
    end
  end
end
