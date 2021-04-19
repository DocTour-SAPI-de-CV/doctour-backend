# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  has_one :account, dependent: :destroy
  has_many :sended_messages, class_name: "ChatMessage", foreign_key: "from_id"
  has_many :received_messages, class_name: "ChatMessage", foreign_key: "to_id"
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
    patient = Patient.find_by(person: account.people)
    medical_history = patient.medical_history
    last_medical_history = medical_history.last[:performed_date] if medical_history.present?
    {
      user_id: id,
      full_name: account.people.full_name,
      email: email,
      gender: account.people.gender,
      document: DocumentsPerson.where(person: account.people).as_json,
      phones: PeoplePhone.where(person: account.people).as_json,
      languages: LanguagesPerson.where(person: account.people).as_json,
      last_medical_history: last_medical_history,
    }
  end

  def medical_history
    Patient.find_by(person: account.people).medical_history
  end

  def have_address?
    AddressesPerson.find_by(person: account.people).nil?
  end

  def as_json(options = nil)
    return assitant if account.category == "assistant"
    return admin if account.category == "admin"
    return doctor if account.category == "doctor"
    return patient if account.category == "patient"
  end

  def basic_info
    {
      id: id,
      email: email,
      category: account.category,
      people: account.people.as_json,
    }
  end

  def assitant
    basic_info.merge!({
                        address: AddressesPerson.find_by(person: account.people).as_json,
                        assistant: Assistant.find_by(person: account.people).as_json,
                      })
  end

  def admin
    basic_info.merge!({
                        address: AddressesPerson.find_by(person: account.people).as_json,
                      })
  end

  def doctor
    basic_info.merge!({
                        address: AddressesPerson.find_by(person: account.people).as_json,
                        doctor: Doctor.find_by(person: account.people).as_json,
                      })
  end

  def patient
    basic_info.merge!({
                        patient: Patient.find_by(person: account.people).as_json,
                      })
  end
end
