# frozen_string_literal: true

class PeoplePhone < ApplicationRecord
  belongs_to :person, class_name: 'People'
  belongs_to :phone

  validates :person,
            presence: true

  validates :phone,
            presence: true
end
