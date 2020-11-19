# frozen_string_literal: true

class Diagnostic < ApplicationRecord
  before_validation :downcase_fields

  validates :code,
            presence: true,
            uniqueness: true

  validates :name,
            presence: true

  def downcase_fields
    name.downcase!
  end
end
