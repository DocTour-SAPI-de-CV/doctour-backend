# frozen_string_literal: true

class Phone < ApplicationRecord
  has_many :people_phones, dependent: :destroy
  has_many :people, through: :people_phones

  has_many :partners_phones, dependent: :destroy
  has_many :partners, through: :partners_phones

  validates :country_code,
            presence: true,
            numericality: true,
            length: { in: 1..4 }

  validates :area_code,
            presence: true,
            numericality: true,
            length: { in: 1..4 }

  validates :number,
            presence: true,
            numericality: true,
            length: { in: 5..10 }
end
