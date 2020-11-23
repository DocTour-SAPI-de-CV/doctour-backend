# frozen_string_literal: true

class Diagnostic < ApplicationRecord
  before_validation :downcase_fields

  has_many :diagnostics_soaps, dependent: :destroy
  has_many :soaps, through: :diagnostics_soaps

  validates :code,
            presence: true,
            uniqueness: true

  validates :name,
            presence: true

  def downcase_fields
    name&.downcase!
  end
end
