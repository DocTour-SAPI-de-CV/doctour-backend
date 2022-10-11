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
    if screening.save
      render(json: { screening: screening }) 
    else
      render(json: { error: screening.errors })
    end
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

  def screening_patient
    # data = Screening.find_screening_patient(params[:id])
    s = Screening.where(patient_id: params[:id]).last
    # puts data.errors.to_json
    render(json: { data: s })
  end

  private

  def screening_params
    params.require(:screening).permit(:performed_at, :reason_consultation, :return,
                                      :patient_id, :respiratory_frequency, :bmi,
                                      :temperature, :heart_rate, :weight, :height)
  end
end
