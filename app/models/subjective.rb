# frozen_string_literal: true

class Subjective < ApplicationRecord
  validates :name,
            uniqueness: { case_sensitive: false },
            format: { with: /[a-zA-Z]/ },
            length: { in: 3..72 },
            presence: true
end
