# frozen_string_literal: true

class AddressController < ApplicationController
  include ErrorSerializer

  # rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { address: Address.all })
  end

  def index
    render(json: { address: Address.find(params[:id]) })
  end

  def create
    address = Address.new(address_params)
    render(json: { address: address }) if address.save

    render(json: { error: address.errors }) unless address.save
  end

  def delete
    @address = Address.find(params[:id])
    @address.destroy!
    render(json: { "address_id deleted": params[:id] })
  end

  def update
    address = Address.find(params[:id])
    render(json: { address: address }) if address.update(address_params)

    render(json: { error: address.errors }) unless address.update(address_params)
  end

  private

  def address_params
    params.require(:address).permit(:street, :street_number, :zipcode, :country, :city, :state)
  end
end
