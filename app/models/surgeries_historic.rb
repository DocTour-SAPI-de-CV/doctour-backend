# frozen_string_literal: true

class SurgeriesHistoric < ApplicationRecord
  belongs_to :pathologicals_historic
  belongs_to :surgery

  validates :pathologicals_historic,
            presence: true

  validates :surgery,
            presence: true
end
