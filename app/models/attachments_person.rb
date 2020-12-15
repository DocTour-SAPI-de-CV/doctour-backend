# frozen_string_literal: true

class AttachmentsPerson < ApplicationRecord
  belongs_to :attachment, inverse_of: :attachments_people

  belongs_to :person, class_name: 'People'

  belongs_to :person_patient,
             class_name: 'People',
             foreign_key: 'person_patient_id',
             inverse_of: :attachments_people

  belongs_to :person_doctor,
             class_name: 'People',
             foreign_key: 'person_doctor_id',
             inverse_of: :attachments_people

  validates :attachment,
            presence: true

  validates :person_doctor,
            presence: true

  validates :person_patient,
            presence: true

  validates :attachment_type,
            presence: true
end
