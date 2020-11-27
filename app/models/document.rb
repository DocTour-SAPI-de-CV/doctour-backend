# frozen_string_literal: true

class Document < ApplicationRecord
  DOCUMENT_TYPES = {
    dgp: 'DGP',
    passport: 'PASSPORT',
    rfc: 'RFC',
    curp: 'CURP'
  }.freeze

  has_many :documents_people, dependent: :destroy
  has_many :people, through: :documents_people

  validates :document_type,
            presence: true,
            inclusion: DOCUMENT_TYPES.values

  validates :number,
            presence: true,
            uniqueness: {
              scope: %i[number document_type]
            }
end
