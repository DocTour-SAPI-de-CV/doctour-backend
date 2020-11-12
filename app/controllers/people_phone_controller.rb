# frozen_string_literal: true

# rubocop:disable Style/GuardClause
class PeoplePhoneController < ApplicationController
  include ErrorSerializer

  # rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { people_phone: PeoplePhone.all })
  end

  def index
    render(json: { people_phone: PeoplePhone.find(params[:id]) })
  end

  def create
    people_phone = PeoplePhone.new(people_phone_params)
    render(json: { people_phone: people_phone }) if people_phone.save

    render(json: { error: people_phone.errors }) unless people_phone.save
  end

  def delete
    @people_phone = PeoplePhone.find(params[:id])
    @people_phone.destroy!
    render(json: { "people_phone_id deleted": params[:id] })
  end

  def update
    people_phone = PeoplePhone.find(params[:id])
    render(json: { people_phone: people_phone }) if people_phone.update(people_phone_params)

    unless people_phone.update(people_phone_params)
      render(json: { error: people_phone.errors })
    end
  end

  private

  def people_phone_params
    params.require(:people_phone).permit(:person_id, :phone_id)
  end
end
# rubocop:enable Style/GuardClause
