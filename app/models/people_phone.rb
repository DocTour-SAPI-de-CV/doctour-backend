# frozen_string_literal: true

class PeoplePhone < ApplicationRecord
  belongs_to :person, class_name: 'People'
  belongs_to :phone

  validates :person,
            presence: true

  validates :phone,
            presence: true

  def as_json
    {
      id: phone.id,
      country_code: phone.country_code,
      area_code: phone.area_code,
      number: phone.number
    }
  end
end
