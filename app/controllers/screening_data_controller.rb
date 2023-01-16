# frozen_string_literal: true

class ScreeningDataController < ApplicationController
  include ErrorSerializer

  # rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { screening_data: ScreeningData.all })
  end

  def index
    render(json: { screening_data: ScreeningData.find(params[:id]) })
  end

  def create
    screening_data = ScreeningData.new(screening_data_params)
    if screening_data.save
      render(json: { screening_data: screening_data }) 
    else
      render(json: { error: screening_data.errors })
    end
  end

  def delete
    @screening_data = ScreeningData.find(params[:id])
    @screening_data.destroy!
    render(json: { "screening_id deleted": params[:id] })
  end

  def update
    screening_data = ScreeningData.find(params[:id])
    render(json: { screening_data: screening_data }) if screening_data.update(screening_data_params)

    render(json: { error: screening_data.errors }) unless screening_data.update(screening_data_params)
  end


  private

  def screening_data_params
    params.require(:screening_data).permit(:patient_id, :user_id,
      :reason_consultation, :respiratory_frequency, :bmi, :temperature, :heart_rate, :weight, :height,

      :peea, :neurological, :genitourinario, :respiratory,:cardiologic, :gastrointestinal, :extremities, :discoveries,

      :exam_request, :exam_name, :exam_result,
      
      :need_return, :main_diagnosis, :full_diagnosis, :secondary_diagnoses, :prognosis,

      :medication, :dosage, :presentation, :route_of_administration, :frequency, :duration, :medicine,
      
      :name, :observation, :exam_medication,
      
      :general_indications
    
    )
  end
end
