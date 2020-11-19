# frozen_string_literal: true

class DiagnosticController < ApplicationController
  include ErrorSerializer

  rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { diagnostics: Diagnostic.all })
  end

  def index
    render(json: { diagnostic: Diagnostic.find(params[:id]) })
  end

  def create
    diagnostic = Diagnostic.new(diagnostic_params)
    render(json: { diagnostic: diagnostic }) if diagnostic.save

    render(json: { error: diagnostic.errors }) unless diagnostic.save
  end

  def delete
    @diagnostic = Diagnostic.find(params[:id])
    @diagnostic.destroy!
    render(json: { "diagnostic_id deleted": params[:id] })
  end

  def update
    diagnostic = Diagnostic.find(params[:id])
    render(json: { diagnostic: diagnostic }) if diagnostic.update(diagnostic_params)

    render(json: { error: diagnostic.errors }) unless diagnostic.update(diagnostic_params)
  end

  private

  def diagnostic_params
    params.require(:diagnostic).permit(:code, :name)
  end
end
