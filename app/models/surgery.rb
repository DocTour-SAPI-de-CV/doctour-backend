# frozen_string_literal: true

class Surgery < ApplicationRecord
  has_many :surgeries_historics, dependent: :destroy
  has_many :pathologicals_historics, through: :surgeries_historics

  validates :name,
            length: { in: 3..72 },
            presence: true
end
