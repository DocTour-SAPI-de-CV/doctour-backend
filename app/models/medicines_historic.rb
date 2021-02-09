# frozen_string_literal: true

class MedicinesHistoric < ApplicationRecord
  belongs_to :pathologicals_historic
  belongs_to :medicine

  validates :pathologicals_historic,
            presence: true

  validates :medicine,
            presence: true
end
