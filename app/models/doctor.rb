# frozen_string_literal: true

class Doctor < ApplicationRecord
  belongs_to :person, class_name: 'People'

  has_one :screening, dependent: :destroy

  has_many :doctors_specializations, dependent: :destroy
  has_many :specializations, through: :doctors_specializations

  validates :person,
            uniqueness: true,
            presence: true

  if :about.present?
    validates :about,
              format: { with: /[a-zA-Z]/ },
              length: { in: 3..300 }
  end

  validates :status,
            inclusion: {
              in: [0, 1, 2],
              message: 'is not valid [0, 1, 2]'
            },
            presence: { message: 'is required or invalid' }

  delegate :full_name, to: :person

  def doctor_document
    DocumentsPerson.find_by(person: person).document.as_json
  end

  def as_json
    {
      id: id,
      photo: photo,
      about: about,
      status: status,
      specializations: DoctorsSpecialization.where(doctor_id: id).as_json
    }
  end
end
