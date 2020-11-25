# frozen_string_literal: true

class Document < ApplicationRecord
  DOCUMENT_TYPES = {
    dgp: 'DGP',
    passport: 'PASSPORT',
    rfc: 'RFC',
    curp: 'CURP'
  }.freeze

  # has_many :documents_patients, dependent: :destroy
  # has_many :patients, through: :documents_patients

  validates :document_type,
            presence: true,
            inclusion: DOCUMENT_TYPES.values

  validates :number,
            presence: true,
            uniqueness: {
              scope: %i[number document_type]
            }
end
