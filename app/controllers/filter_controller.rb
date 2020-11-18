class FilterController < ApplicationController
  include ErrorSerializer

  rescue_from ActionController::ParameterMissing, with: :missing_params

  def patient
    @patient = PatientFinder.new(nil).find(params[:id])
    render(json: { patient: @patient })
  end
end