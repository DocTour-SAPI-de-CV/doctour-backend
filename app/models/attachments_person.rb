# frozen_string_literal: true

class AttachmentsPerson < ApplicationRecord
  belongs_to :attachment

  belongs_to :person_patient,
             class_name: 'People',
             foreign_key: 'person_patient_id',
             optional: true

  belongs_to :person_doctor,
             class_name: 'People',
             foreign_key: 'person_doctor_id',
             optional: true

  belongs_to :person_doctor,
              class_name: 'People',
              foreign_key: 'person_assistant_id',
              optional: true

  belongs_to :attachment_type, dependent: :destroy

  validates :attachment,
            presence: true

  # validates :person_doctor,
  #           presence: true

  # validates :person_patient,
  #           presence: true

  validates :attachment_type,
            presence: true
end
