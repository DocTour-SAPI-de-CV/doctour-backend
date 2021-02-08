# frozen_string_literal: true

class AllergiesHistoric < ApplicationRecord
  belongs_to :allergy
  belongs_to :pathologicals_historic

  validates :allergy,
            presence: true

  validates :pathologicals_historic,
            presence: true
end
