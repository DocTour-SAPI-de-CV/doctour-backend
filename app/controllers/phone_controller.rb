# frozen_string_literal: true

class PhoneController < ApplicationController
  include ErrorSerializer

  # rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { phone: Phone.all })
  end

  def index
    render(json: { phone: Phone.find(params[:id]) })
  end

  def create
    phone = Phone.new(phone_params)
    render(json: { phone: phone }) if phone.save

    render(json: { error: phone.errors }) unless phone.save
  end

  def delete
    @phone = Phone.find(params[:id])
    @phone.destroy!
    render(json: { "phone_id deleted": params[:id] })
  end

  def update
    phone = Phone.find(params[:id])
    render(json: { phone: phone }) if phone.update(phone_params)

    render(json: { error: phone.errors }) unless phone.update(phone_params)
  end

  private

  def phone_params
    params.require(:phone).permit(:country_code, :area_code, :number)
  end
end
