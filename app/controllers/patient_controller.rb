# frozen_string_literal: true

class PatientController < ApplicationController
  include ErrorSerializer

  rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { patients: Patient.all })
  end

  def index
    render(json: { patient: Patient.find(params[:id]) })
  end

  def create
    patient = Patient.new(patient_params)
    render(json: { patient: patient }) if patient.save

    render(json: { error: patient.errors }) unless patient.save
  end

  def delete
    @patient = Patient.find(params[:id])
    @patient.destroy!

    render(json: { "patient_id deleted": params[:id] })
  end

  def update
    patient = Patient.find(params[:id])
    render(json: { patient: patient }) if patient.update(patient_params)

    render(json: { error: patient.errors }) unless patient.update(patient_params)
  end

  private

  def patient_params
    params.require(:patient).permit(:privacy_polity, :terms_use, :people_id, :client_ip)
  end
end
