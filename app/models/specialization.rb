# frozen_string_literal: true

class Specialization < ApplicationRecord
  has_many :doctors_specializations, dependent: :destroy
  has_many :doctors, through: :doctors_specializations

  validates :name,
            uniqueness: { case_sensitive: false },
            format: { with: /[a-zA-Z]/ },
            length: { in: 3..72 },
            presence: true
end
