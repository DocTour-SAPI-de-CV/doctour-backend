# frozen_string_literal: true

class FamilyHistoricsController < ApplicationController
  include ErrorSerializer

  # rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { family_historic: FamilyHistoric.all })
  end

  def index
    render(json: { family_historic: FamilyHistoric.find(params[:id]) })
  end

  def create
    family_historic = FamilyHistoric.new(family_historic_params)
    render(json: { family_historic: family_historic }) if family_historic.save

    render(json: { error: family_historic.errors }) unless family_historic.save
  end

  def delete
    @family_historic = FamilyHistoric.find(params[:id])
    @family_historic.destroy!
    render(json: { "screening_id deleted": params[:id] })
  end

  def update
    family_historic = FamilyHistoric.find(params[:id])
    render(json: { family_historic: family_historic }) if family_historic.update(family_historic_params)

    render(json: { error: family_historic.errors }) unless family_historic.update(family_historic_params)
  end

  private

  def family_historic_params
    params.require(:family_historic).permit(:patient_id, :history_family_illnesses, 
                                            :side_family, :mother_side, :father_side)
  end
end
