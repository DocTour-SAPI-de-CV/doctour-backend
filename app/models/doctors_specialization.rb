# frozen_string_literal: true

class DoctorsSpecialization < ApplicationRecord
  belongs_to :doctor
  belongs_to :specialization

  validates :doctor,
            presence: true

  validates :specialization,
            presence: true
  
  def as_json
    {
      id: id,
      name: specialization.name
    }
  end
end
