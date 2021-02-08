# frozen_string_literal: true

class RespiratoriesHistoric < ApplicationRecord
  belongs_to :respiratories_disease
  belongs_to :pathologicals_historic

  validates :pathologicals_historic,
            presence: true

  validates :respiratories_disease,
            presence: true
end
