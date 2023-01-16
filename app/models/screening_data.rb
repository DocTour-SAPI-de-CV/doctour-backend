# frozen_string_literal: true

class ScreeningData < ApplicationRecord
  # belongs_to :doctor
  belongs_to :patient
  belongs_to :user
end
