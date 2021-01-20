# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  has_one :account, dependent: :destroy

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            email: true

  validates :password,
            presence: true,
            length: { in: 8..72 }

  devise :registerable,
         :database_authenticatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self

  def patient_summary
    {
      user_id: id,
      full_name: account.people.full_name,
      last_medical_history: Screening.where(
        patient: Patient.find_by(
          person: account.people)).last.performed_date
    }
  end

  def as_json
    return assitant if account.category == 'assistant'
    return admin if account.category == 'admin'
    return doctor if account.category == 'doctor'
    return patient if account.category == 'patient'
  end

  def basic_info
    {
      id: id,
      email: email,
      category: account.category,
      people: account.people.as_json
    }
  end

  def assitant
    basic_info.merge!({
      address: AddressesPerson.find_by(person_id: account.people.id).as_json,
      assistant: Assistant.find_by(person_id: account.people.id).as_json
    })
  end

  def admin
    basic_info.merge!({
      address: AddressesPerson.find_by(person_id: account.people.id).as_json
    })
  end

  def doctor
    basic_info.merge!({
      address: AddressesPerson.find_by(person_id: account.people.id).as_json,
      doctor: Doctor.find_by(person_id: account.people.id).as_json
    })
  end

  def patient
    basic_info.merge!({
      patient: Patient.find_by(person_id: account.people.id).as_json
    })
  end
end
