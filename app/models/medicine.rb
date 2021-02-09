# frozen_string_literal: true

class Medicine < ApplicationRecord
  has_many :medicines_historics, dependent: :destroy
  has_many :pathologicals_historics, through: :medicines_historics

  validates :name,
            length: { in: 3..72 },
            presence: true
end
