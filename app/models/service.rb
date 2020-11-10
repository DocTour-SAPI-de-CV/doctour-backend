# frozen_string_literal: true

class Service < ApplicationRecord
  validates :name,
            uniqueness: { case_sensitive: false },
            format: { with: /[a-zA-Z]/ },
            length: { in: 3..72 },
            presence: true

  validates :price,
            numericality: { only_float: true },
            presence: true

  validates :description,
            length: { in: 3..300 }
end
