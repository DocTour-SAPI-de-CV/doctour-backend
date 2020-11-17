# frozen_string_literal: true

class Address < ApplicationRecord
  has_many :addresses_people, dependent: :destroy
  has_many :people, through: :addresses_people

  validates :street,
            length: { in: 4..80 },
            presence: true

  validates :street_number,
            numericality: { only_integer: true,
                            greater_than_or_equal_to: 1 },
            length: { in: 1..5 },
            presence: true

  validates :zipcode,
            length: { in: 4..8 },
            presence: true

  validates :country,
            length: { in: 4..40 },
            presence: true

  validates :city,
            length: { in: 3..40 },
            presence: true

  validates :state,
            length: { in: 3..40 },
            presence: true
end
