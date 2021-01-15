# frozen_string_literal: true

class AddressesPerson < ApplicationRecord
  belongs_to :address
  belongs_to :person, class_name: 'People'

  validates :person,
            presence: true

  validates :address,
            presence: true

  def as_json
    {
      id: address.id,
      street: address.street,
      street_number: address.street_number,
      zipcode: address.zipcode,
      country: address.country,
      city: address.city,
      state: address.state 
    }
  end
end
