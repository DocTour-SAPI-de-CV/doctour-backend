# frozen_string_literal: true

class FilterController < ApplicationController
  include ErrorSerializer

  rescue_from ActionController::ParameterMissing, with: :missing_params

  def patient
    @patient = PatientFinder.new(nil).find(params[:id])
    render(json: { patient: @patient })
  end

  def patient_name
    @patient = PatientFinder.new(nil).find_name(params[:name])
    if @patient.count.zero?
      render(json: { Erro: 'No patient with that name was found' })
    else
      render(json: { patient: @patient })
    end
  end

  def diagnostic
    @diagnostic = DiagnosticFinder.new(nil).find(params)
    render(json: { diagnostic: @diagnostic })
  end
end
