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

  def as_json
    return assitant if account.category == 'assistant'
    return admin if account.category == 'admin'
    return doctor if account.category == 'doctor'
    return patient if account.category == 'patient'
  end

  def assitant
    {
      email: email,
      category: account.category,
      people: account.people.as_json,
      address: AddressesPerson.find_by(person_id: account.people.id).as_json,
      assistant: Assistant.find_by(person_id: account.people.id).as_json
    }
  end

  def admin
    {
      email: email,
      category: account.category,
      people: account.people.as_json,
      address: AddressesPerson.find_by(person_id: account.people.id).as_json
    }
  end

  def doctor
    {
      email: email,
      category: account.category,
      people: account.people.as_json,
      address: AddressesPerson.find_by(person_id: account.people.id).as_json,
      doctor: Doctor.find_by(person_id: account.people.id).as_json
    }
  end

  def patient
    {
      email: email,
      category: account.category,
      people: account.people.as_json,
      patient: Patient.find_by(person_id: account.people.id).as_json
    }
  end
end
