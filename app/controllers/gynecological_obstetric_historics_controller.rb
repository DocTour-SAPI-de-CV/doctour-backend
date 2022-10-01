# frozen_string_literal: true

class GynecologicalObstetricHistoricsController < ApplicationController
  include ErrorSerializer

  # rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { gynecological_obstetric_historic: GynecologicalObstetricHistoric.all })
  end

  def index
    render(json: { gynecological_obstetric_historic: GynecologicalObstetricHistoric.find(params[:id]) })
  end

  def create
    gyne_historic = GynecologicalObstetricHistoric.new(gynecological_obstetric_historic_params)
    if gyne_historic.save
      render(json: { gynecological_obstetric_historic: gyne_historic })
      ScreeningChannel.broadcast_to 'new_screening', screening_id: 1
    else
      render(json: { error: gyne_historic.errors })
    end
  end

  def delete
    @gyne_historic = GynecologicalObstetricHistoric.find(params[:id])
    @gyne_historic.destroy!
    render(json: { "screening_id deleted": params[:id] })
  end

  def update
    gyne_historic = GynecologicalObstetricHistoric.find(params[:id])
    render(json: { gynecological_obstetric_historic: gyne_historic }) if gyne_historic.update(gynecological_obstetric_historic_params)

    render(json: { error: gyne_historic.errors }) unless gyne_historic.update(gynecological_obstetric_historic_params)
  end

  private

  def gynecological_obstetric_historic_params
    params.require(:gynecological_obstetric_historic).permit(:patient_id, :last_menstrual_cycle,
                                            :pregnancy, :number_pregnancies, :normal_deliveries,
                                            :cesarean_deliveries, :abortion, :number_abortion, :contraceptive_methods)
  end
end
