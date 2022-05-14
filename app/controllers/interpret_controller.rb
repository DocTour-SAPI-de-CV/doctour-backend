# frozen_string_literal: true

class InterpretController < ApplicationController
  include ErrorSerializer

  # rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { interpret: Interpret.all })
  end

  def index
    render(json: { interpret: Interpret.find(params[:id]) })
  end

  def create
    interpret = Interpret.new(interpret_params)
    render(json: { interpret: interpret }) if interpret.save

    render(json: { error: interpret.errors }) unless interpret.save
  end

  def delete
    @interpret = Interpret.find(params[:id])
    @interpret.destroy!
    render(json: { "interpret_id deleted": params[:id] })
  end

  def update
    interpret = Interpret.find(params[:id])
    render(json: { interpret: interpret }) if interpret.update(interpret_params)

    render(json: { error: interpret.errors }) unless interpret.update(interpret_params)
  end

  private

  def interpret_params
    params.require(:interpret).permit(:first_name, :last_name, :email, :phone, :languages, :available_times)
  end
end
