# frozen_string_literal: true

class Document < ApplicationRecord
  before_validation :downcase_fields

  has_many :documents_people, dependent: :destroy
  has_many :people, through: :documents_people

  has_many :documents_partners, dependent: :destroy
  has_many :partners, through: :documents_partners

  validates :document_type,
            presence: true,
            inclusion: {
              in: %w[
                dgp
                passport
                rfc
                curp
              ],
              message: 'is not valid'
            }

  validates :number,
            presence: true,
            uniqueness: {
              scope: %i[number document_type]
            }

  def downcase_fields
    document_type&.downcase!
  end
end
