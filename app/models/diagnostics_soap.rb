# frozen_string_literal: true

class DiagnosticsSoap < ApplicationRecord
  belongs_to :soap
  belongs_to :diagnostic

  validates :diagnostic,
            presence: true

  validates :soap,
            presence: true
end
