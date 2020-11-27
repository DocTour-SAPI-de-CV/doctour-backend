# frozen_string_literal: true

class DocumentsPartner < ApplicationRecord
  belongs_to :partner
  belongs_to :document

  validates :partner,
            presence: true

  validates :document,
            presence: true
end
