# frozen_string_literal: true

# rubocop:disable Style/GuardClause
class DocumentsPartnerController < ApplicationController
  include ErrorSerializer

  # rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { documents_partner: DocumentsPartner.all })
  end

  def index
    render(json: { documents_partner: DocumentsPartner.find(params[:id]) })
  end

  def create
    documents_partner = DocumentsPartner.new(documents_partner_params)
    render(json: { documents_partner: documents_partner }) if documents_partner.save

    render(json: { error: documents_partner.errors }) unless documents_partner.save
  end

  def delete
    @documents_partner = DocumentsPartner.find(params[:id])
    @documents_partner.destroy!
    render(json: { "documents_partner_id deleted": params[:id] })
  end

  def update
    documents_partner = DocumentsPartner.find(params[:id])
    if documents_partner.update(documents_partner_params)
      render(json: { documents_partner: documents_partner })
    end

    unless documents_partner.update(documents_partner_params)
      render(json: { error: documents_partner.errors })
    end
  end

  private

  def documents_partner_params
    params.require(:documents_partner).permit(:partner_id, :document_id)
  end
end
# rubocop:enable Style/GuardClause
