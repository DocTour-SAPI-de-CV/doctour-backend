# frozen_string_literal: true

# rubocop:disable Style/GuardClause
class PartnersPhoneController < ApplicationController
  include ErrorSerializer

  # rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { partners_phone: PartnersPhone.all })
  end

  def index
    render(json: { partners_phone: PartnersPhone.find(params[:id]) })
  end

  def create
    partners_phone = PartnersPhone.new(partners_phone_params)
    render(json: { partners_phone: partners_phone }) if partners_phone.save

    render(json: { error: partners_phone.errors }) unless partners_phone.save
  end

  def delete
    @partners_phone = PartnersPhone.find(params[:id])
    @partners_phone.destroy!
    render(json: { "partners_phone_id deleted": params[:id] })
  end

  def update
    partners_phone = PartnersPhone.find(params[:id])
    if partners_phone.update(partners_phone_params)
      render(json: { partners_phone: partners_phone })
    end

    unless partners_phone.update(partners_phone_params)
      render(json: { error: partners_phone.errors })
    end
  end

  private

  def partners_phone_params
    params.require(:partners_phone).permit(:partner_id, :phone_id)
  end
end
# rubocop:enable Style/GuardClause
