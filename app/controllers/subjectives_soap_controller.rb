# frozen_string_literal: true

# rubocop:disable Style/GuardClause
class SubjectivesSoapController < ApplicationController
  include ErrorSerializer

  # rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { subjectives_soap: SubjectivesSoap.all })
  end

  def index
    render(json: { subjectives_soap: SubjectivesSoap.find(params[:id]) })
  end

  def create
    subjectives_soap = SubjectivesSoap.new(subjectives_soap_params)
    render(json: { subjectives_soap: subjectives_soap }) if subjectives_soap.save

    render(json: { error: subjectives_soap.errors }) unless subjectives_soap.save
  end

  def delete
    @subjectives_soap = SubjectivesSoap.find(params[:id])
    @subjectives_soap.destroy!
    render(json: { "subjectives_soap_id deleted": params[:id] })
  end

  def update
    subjectives_soap = SubjectivesSoap.find(params[:id])
    if subjectives_soap.update(subjectives_soap_params)
      render(json: { subjectives_soap: subjectives_soap })
    end

    unless subjectives_soap.update(subjectives_soap_params)
      render(json: { error: subjectives_soap.errors })
    end
  end

  private

  def subjectives_soap_params
    params.require(:subjectives_soap).permit(:subjective_id, :soap_id)
  end
end
# rubocop:enable Style/GuardClause
