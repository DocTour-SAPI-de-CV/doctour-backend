# frozen_string_literal: true

class AddressesPerson < ApplicationRecord
  belongs_to :address
  belongs_to :person, class_name: 'People'

  validates :person,
            presence: true

  validates :address,
            presence: true
end
