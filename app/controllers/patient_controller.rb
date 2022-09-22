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
    if current_user.account.category == "patient"
      unauthorized("admin")
      return
    end
    patient = Patient.new(patient_params)
    render(json: { patient: patient }) if patient.save

    render(json: { error: patient.errors }) unless patient.save
  end

  def delete
    @patient = Patient.find(params[:id])
    @patient.destroy!

    render(json: { "patient_id  deleted": params[:id] })
  end

  def update
    if current_user.account.category == "patient"
      unless params[:id] == current_user.account.people.patient.id
        unauthorized("admin")
        return
      end
    end
    patient = Patient.find(params[:id])
    if patient.update(patient_params)
      render(json: { patient: patient })
    else
      render(json: { error: patient.errors })
    end
  end

  def find_user
    render(json: { user: User.find_user(params[:email]) })
  end

  private

  def patient_params
    params.require(:patient).permit(:privacy_policy, :photo, :terms_use, :people_id, :client_ip)
  end
end
