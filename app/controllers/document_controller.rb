# frozen_string_literal: true

class DocumentController < ApplicationController
  include ErrorSerializer

  # rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { document: Document.all })
  end

  def index
    render(json: { document: Document.find(params[:id]) })
  end

  def create
    document = Document.new(document_params)
    render(json: { document: document }) if document.save

    render(json: { error: document.errors }) unless document.save
  end

  def delete
    @document = Document.find(params[:id])
    @document.destroy!
    render(json: { "document_id deleted": params[:id] })
  end

  def update
    document = Document.find(params[:id])
    render(json: { document: document }) if document.update(document_params)

    render(json: { error: document.errors }) unless document.update(document_params)
  end

  private

  def document_params
    params.require(:document).permit(:document_type, :number)
  end
end
