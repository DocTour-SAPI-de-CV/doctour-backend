# frozen_string_literal: true

# rubocop:disable Style/GuardClause
class DoctorsSpecializationController < ApplicationController
  include ErrorSerializer

  # rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { doctors_specialization: DoctorsSpecialization.all })
  end

  def index
    render(json: { doctors_specialization: DoctorsSpecialization.find(params[:id]) })
  end

  def create
    doctors_specialization = DoctorsSpecialization.new(doctors_specialization_params)
    if doctors_specialization.save
      render(json: { doctors_specialization: doctors_specialization })
    end

    render(json: { error: doctors_specialization.errors }) unless doctors_specialization.save
  end

  def delete
    @doctors_specialization = DoctorsSpecialization.find(params[:id])
    @doctors_specialization.destroy!
    render(json: { "doctors_specialization_id deleted": params[:id] })
  end

  def update
    doctors_specialization = DoctorsSpecialization.find(params[:id])
    if doctors_specialization.update(doctors_specialization_params)
      render(json: { doctors_specialization: doctors_specialization })
    end

    unless doctors_specialization.update(doctors_specialization_params)
      render(json: { error: doctors_specialization.errors })
    end
  end

  private

  def doctors_specialization_params
    params.require(:doctors_specialization).permit(:doctor_id, :specialization_id)
  end
end
# rubocop:enable Style/GuardClause
