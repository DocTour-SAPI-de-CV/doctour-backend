# frozen_string_literal: true

class SoapController < ApplicationController
  include ErrorSerializer

  def show
    render(json: { soaps: Soap.all })
  end

  def index
    render(json: { soap: Soap.find(params[:id]) })
  end

  def create
    soap = Soap.new(soap_params)
    render(json: { soap: soap }) if soap.save

    render(json: { error: soap.errors }) unless soap.save
  end

  def delete
    @soap = Soap.find(params[:id])
    @soap.destroy!
    render(json: { "soap_id deleted": params[:id] })
  end

  def update
    soap = Soap.find(params[:id])
    render(json: { soap: soap }) if soap.update(soap_params)

    render(json: { error: soap.errors }) unless soap.update(soap_params)
  end

  private

  def soap_params
    params.require(:soap).permit(:subjective, :objective,
                                 :assessment, :plan, :medical_description,
                                 :medical_report, :observation)
  end
end
