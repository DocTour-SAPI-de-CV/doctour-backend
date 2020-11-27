# frozen_string_literal: true

class PartnerController < ApplicationController
  include ErrorSerializer

  def show
    render(json: { partner: Partner.all })
  end

  def index
    render(json: { partner: Partner.find(params[:id]) })
  end

  def create
    partner = Partner.new(partner_params)
    render(json: { partner: partner }) if partner.save

    render(json: { error: partner.errors }) unless partner.save
  end

  def delete
    @partner = Partner.find(params[:id])
    @partner.destroy!
    render(json: { "partner_id deleted": params[:id] })
  end

  def update
    partner = Partner.find(params[:id])
    render(json: { partner: partner }) if partner.update(partner_params)

    render(json: { error: partner.errors }) unless partner.update(partner_params)
  end

  private

  def partner_params
    params.require(:partner).permit(:name, :responsible_name, :observation)
  end
end
