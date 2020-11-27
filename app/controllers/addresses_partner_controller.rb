# frozen_string_literal: true

# rubocop:disable Style/GuardClause
class AddressesPartnerController < ApplicationController
  include ErrorSerializer

  # rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { addresses_partner: AddressesPartner.all })
  end

  def index
    render(json: { addresses_partner: AddressesPartner.find(params[:id]) })
  end

  def create
    addresses_partner = AddressesPartner.new(addresses_partner_params)
    render(json: { addresses_partner: addresses_partner }) if addresses_partner.save

    render(json: { error: addresses_partner.errors }) unless addresses_partner.save
  end

  def delete
    @addresses_partner = AddressesPartner.find(params[:id])
    @addresses_partner.destroy!
    render(json: { "addresses_partner_id deleted": params[:id] })
  end

  def update
    addresses_partner = AddressesPartner.find(params[:id])
    if addresses_partner.update(addresses_partner_params)
      render(json: { addresses_partner: addresses_partner })
    end

    unless addresses_partner.update(addresses_partner_params)
      render(json: { error: addresses_partner.errors })
    end
  end

  private

  def addresses_partner_params
    params.require(:addresses_partner).permit(:partner_id, :address_id)
  end
end
# rubocop:enable Style/GuardClause
