# frozen_string_literal: true

class Objective < ApplicationRecord
  has_many :objectives_soaps, dependent: :destroy
  has_many :soaps, through: :objectives_soaps

  has_many :subjectives_soaps, dependent: :destroy
  has_many :soaps, through: :subjectives_soaps

  validates :name,
            uniqueness: { case_sensitive: false },
            format: { with: /[a-zA-Z]/ },
            length: { in: 3..72 },
            presence: true
end
