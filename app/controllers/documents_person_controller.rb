# frozen_string_literal: true

# rubocop:disable Style/GuardClause
class DocumentsPersonController < ApplicationController
  include ErrorSerializer

  # rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { documents_person: DocumentsPerson.all })
  end

  def index
    render(json: { documents_person: DocumentsPerson.find(params[:id]) })
  end

  def create
    documents_person = DocumentsPerson.new(documents_person_params)
    render(json: { documents_person: documents_person }) if documents_person.save

    render(json: { error: documents_person.errors }) unless documents_person.save
  end

  def delete
    @documents_person = DocumentsPerson.find(params[:id])
    @documents_person.destroy!
    render(json: { "documents_person_id deleted": params[:id] })
  end

  def update
    documents_person = DocumentsPerson.find(params[:id])
    if documents_person.update(documents_person_params)
      render(json: { documents_person: documents_person })
    end

    unless documents_person.update(documents_person_params)
      render(json: { error: documents_person.errors })
    end
  end

  private

  def documents_person_params
    params.require(:documents_person).permit(:person_id, :document_id)
  end
end
# rubocop:enable Style/GuardClause
