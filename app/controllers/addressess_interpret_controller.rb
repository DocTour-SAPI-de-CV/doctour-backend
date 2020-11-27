# frozen_string_literal: true

# rubocop:disable Style/GuardClause

class AddressessInterpretController < ApplicationController
  include ErrorSerializer

  # rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { addresses_interpret: AddressessInterpret.all })
  end

  def index
    render(json: { addresses_interpret: AddressessInterpret.find(params[:id]) })
  end

  def create
    addresses_interpret = AddressessInterpret.new(addresses_interpret_params)
    render(json: { addresses_interpret: addresses_interpret }) if addresses_interpret.save

    render(json: { error: addresses_interpret.errors }) unless addresses_interpret.save
  end

  def delete
    @addresses_interpret = AddressessInterpret.find(params[:id])
    @addresses_interpret.destroy!
    render(json: { "addresses_interpret_id deleted": params[:id] })
  end

  def update
    addresses_interpret = AddressessInterpret.find(params[:id])
    if addresses_interpret.update(addresses_interpret_params)
      render(json: { addresses_interpret: addresses_interpret })
    end

    unless addresses_interpret.update(addresses_interpret_params)
      render(json: { error: addresses_interpret.errors })
    end
  end

  private

  def addresses_interpret_params
    params.require(:addresses_interpret).permit(:address_id, :interpret_id)
  end
end
# rubocop:enable Style/GuardClause
