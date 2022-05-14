# frozen_string_literal: true

class Patient < ApplicationRecord
  belongs_to :person, class_name: 'People'

  has_one :pathologicals_historic, dependent: :destroy

  has_one :screening, dependent: :destroy

  validates :person, uniqueness: true

  validates :privacy_policy,
            inclusion: { in: [true],
                         message: 'You need to accept the Privacy Policy terms!' },
            presence: true

  validates :client_ip, presence: { message: 'is invalid!' }

  validates :terms_use,
            inclusion: { in: [true],
                         message: 'You need to accept the terms of use!' },
            presence: true

  def last_medical_history
    medical_history.last[:performed_date] if medical_history.present?
  end

  def medical_history
    Screening.where(patient_id: id).as_json
  end

  def created_at_mask
    created_at.strftime('%m/%d/%Y at %I:%M%p')
  end

  delegate :full_name, to: :person

  def email
    person.account.user.email
  end

  def as_json
    {
      id: id,
      photo: photo,
      privacy_policy: privacy_policy,
      terms_use: terms_use,
      client_ip: client_ip.to_s,
      last_medical_history: last_medical_history,
      created_at_mask: created_at_mask
    }
  end
end
