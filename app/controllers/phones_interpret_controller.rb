# frozen_string_literal: true

# rubocop:disable Style/GuardClause

class PhonesInterpretController < ApplicationController
  include ErrorSerializer

  # rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { phones_interpret: PhonesInterpret.all })
  end

  def index
    render(json: { phones_interpret: PhonesInterpret.find(params[:id]) })
  end

  def create
    phones_interpret = PhonesInterpret.new(phones_interpret_params)
    render(json: { phones_interpret: phones_interpret }) if phones_interpret.save

    render(json: { error: phones_interpret.errors }) unless phones_interpret.save
  end

  def delete
    @phones_interpret = PhonesInterpret.find(params[:id])
    @phones_interpret.destroy!
    render(json: { "phones_interpret_id deleted": params[:id] })
  end

  def update
    phones_interpret = PhonesInterpret.find(params[:id])
    if phones_interpret.update(phones_interpret_params)
      render(json: { phones_interpret: phones_interpret })
    end

    unless phones_interpret.update(phones_interpret_params)
      render(json: { error: phones_interpret.errors })
    end
  end

  private

  def phones_interpret_params
    params.require(:phones_interpret).permit(:phone_id, :interpret_id)
  end
end
# rubocop:enable Style/GuardClause
