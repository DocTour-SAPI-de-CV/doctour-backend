# frozen_string_literal: true

class DoctorsSpecialization < ApplicationRecord
  belongs_to :doctor
  belongs_to :specialization

  validates :doctor,
            presence: true

  validates :specialization,
            presence: true
end
