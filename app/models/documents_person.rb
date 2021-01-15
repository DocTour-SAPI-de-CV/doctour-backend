# frozen_string_literal: true

class DocumentsPerson < ApplicationRecord
  belongs_to :document
  belongs_to :person, class_name: 'People'

  validates :person,
            presence: true

  validates :document,
            presence: true

  def as_json
    {
      id: document.id,
      document_number: document.number,
      document_type: document.document_type
    }
  end
end
