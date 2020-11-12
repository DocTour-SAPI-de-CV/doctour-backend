# frozen_string_literal: true

# rubocop:disable Style/GuardClause
class ObjectivesSoapController < ApplicationController
  include ErrorSerializer

  # rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { objectives_soap: ObjectivesSoap.all })
  end

  def index
    render(json: { objectives_soap: ObjectivesSoap.find(params[:id]) })
  end

  def create
    objectives_soap = ObjectivesSoap.new(objectives_soap_params)
    render(json: { objectives_soap: objectives_soap }) if objectives_soap.save

    render(json: { error: objectives_soap.errors }) unless objectives_soap.save
  end

  def delete
    @objectives_soap = ObjectivesSoap.find(params[:id])
    @objectives_soap.destroy!
    render(json: { "objectives_soap_id deleted": params[:id] })
  end

  def update
    objectives_soap = ObjectivesSoap.find(params[:id])
    if objectives_soap.update(objectives_soap_params)
      render(json: { objectives_soap: objectives_soap })
    end

    unless objectives_soap.update(objectives_soap_params)
      render(json: { error: objectives_soap.errors })
    end
  end

  private

  def objectives_soap_params
    params.require(:objectives_soap).permit(:objective_id, :soap_id)
  end
end
# rubocop:enable Style/GuardClause
