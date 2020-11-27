# frozen_string_literal: true

class AddressesInterpret < ApplicationRecord
  belongs_to :address
  belongs_to :interpret

  validates :address,
            presence: true

  validates :interpret,
            presence: true
end
