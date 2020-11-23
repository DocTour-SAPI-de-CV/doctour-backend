# frozen_string_literal: true

class ScreeningController < ApplicationController
  include ErrorSerializer

  # rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { screening: Screening.all })
  end

  def index
    render(json: { screening: Screening.find(params[:id]) })
  end

  def create
    screening = Screening.new(screening_params)
    render(json: { screening: screening }) if screening.save

    render(json: { error: screening.errors }) unless screening.save
  end

  def delete
    @screening = Screening.find(params[:id])
    @screening.destroy!
    render(json: { "screening_id deleted": params[:id] })
  end

  def update
    screening = Screening.find(params[:id])
    render(json: { screening: screening }) if screening.update(screening_params)

    render(json: { error: screening.errors }) unless screening.update(screening_params)
  end

  private

  def screening_params
    params.require(:screening).permit(:performed_at, :return, :doctor_id, :patient_id,
                                      :temperature, :heart_rate, :blood_pressure,
                                      :weight, :height)
  end
end
