# frozen_string_literal: true

class AddressesPartner < ApplicationRecord
  belongs_to :partner
  belongs_to :address

  validates :partner,
            presence: true

  validates :address,
            presence: true
end
