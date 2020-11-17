# frozen_string_literal: true

# rubocop:disable Style/GuardClause
class AddressesPersonController < ApplicationController
  include ErrorSerializer

  # rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { addresses_person: AddressesPerson.all })
  end

  def index
    render(json: { addresses_person: AddressesPerson.find(params[:id]) })
  end

  def create
    addresses_person = AddressesPerson.new(addresses_person_params)
    render(json: { addresses_person: addresses_person }) if addresses_person.save

    render(json: { error: addresses_person.errors }) unless addresses_person.save
  end

  def delete
    @addresses_person = AddressesPerson.find(params[:id])
    @addresses_person.destroy!
    render(json: { "addresses_person_id deleted": params[:id] })
  end

  def update
    addresses_person = AddressesPerson.find(params[:id])
    if addresses_person.update(addresses_person_params)
      render(json: { addresses_person: addresses_person })
    end

    unless addresses_person.update(addresses_person_params)
      render(json: { error: addresses_person.errors })
    end
  end

  private

  def addresses_person_params
    params.require(:addresses_person).permit(:person_id, :address_id)
  end
end
# rubocop:enable Style/GuardClause
