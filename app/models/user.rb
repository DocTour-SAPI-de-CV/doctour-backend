# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  has_one :account, dependent: :destroy
  has_many :sended_messages, class_name: "ChatMessage", foreign_key: "from_id"
  has_many :received_messages, class_name: "ChatMessage", foreign_key: "to_id"
  has_many :user_chat_rooms
  has_many :chat_rooms, through: :user_chat_rooms
  has_many :validation_date, class_name: "validation_date", foreign_key: "id"

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
    {
      user_id: id,
      full_name: account.people.full_name,
      email: email,
      gender: account.people.gender,
      document: DocumentsPerson.where(person: account.people).as_json,
      phones: PeoplePhone.where(person: account.people).as_json,
      languages: LanguagesPerson.where(person: account.people).as_json,
      last_medical_history: patient.last_medical_history,
      created_at_mask: patient.created_at_mask
    }
  end

  def medical_history
    Patient.find_by(person: account.people).medical_history
  end

  def have_address?
    AddressesPerson.find_by(person: account.people).nil?
  end

  def as_json(options = nil)
    return assistant if account.category == "assistant"
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

  def assistant
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

  def chat_messages
    ChatMessage.where('from_id = ? OR to_id = ?', id, id)
  end

  def name
    account.people.full_name
  end

  def self.find_user(email)
    ActiveRecord::Base.connection.execute(
      "SELECT * FROM public.users as users 
      INNER JOIN public.accounts ON users.id=accounts.user_id 
      INNER JOIN public.people ON people.account_id=accounts.id 
      INNER JOIN public.patients ON patients.person_id=people.id 
      WHERE users.email=\'#{email}\'").first()
  end

end
