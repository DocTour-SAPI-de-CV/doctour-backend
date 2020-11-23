# frozen_string_literal: true

class Doctor < ApplicationRecord
  belongs_to :person, class_name: 'People'

  has_one :screening, dependent: :destroy

  has_many :doctors_specializations, dependent: :destroy
  has_many :specializations, through: :doctors_specializations

  validates :person,
            uniqueness: true,
            presence: true

  validates :photo,
            presence: true

  validates :about,
            format: { with: /[a-zA-Z]/ },
            length: { in: 3..300 },
            presence: true
end
