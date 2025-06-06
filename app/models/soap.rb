# frozen_string_literal: true

class Soap < ApplicationRecord
  has_many :objectives_soaps, dependent: :destroy
  has_many :objectives, through: :objectives_soaps

  has_many :subjectives_soaps, dependent: :destroy
  has_many :subjectives, through: :subjectives_soaps

  has_many :diagnostics_soaps, dependent: :destroy
  has_many :diagnostics, through: :diagnostics_soaps

  belongs_to :screening

  validates :assessment,
            format: { with: /[a-zA-Z]/ },
            length: { in: 3..300 },
            presence: true

  validates :plan,
            format: { with: /[a-zA-Z]/ },
            length: { in: 3..300 },
            presence: true

  validates :subjective,
            length: { in: 3..300 }

  validates :objective,
            length: { in: 3..300 }

  validates :observation,
            length: { in: 3..300 }
end
