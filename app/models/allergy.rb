# frozen_string_literal: true

class Allergy < ApplicationRecord
  has_many :allergies_historics, dependent: :destroy
  has_many :pathologicals_historics, through: :allergies_historics

  validates :name,
            length: { in: 3..72 },
            presence: true
end
