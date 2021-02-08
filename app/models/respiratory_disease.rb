# frozen_string_literal: true

class RespiratoryDisease < ApplicationRecord
  has_many :respiratories_historics, dependent: :destroy
  has_many :pathologicals_historics, through: :respiratories_historics

  validates :name,
            length: { in: 3..72 },
            presence: true
end
