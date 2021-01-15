# frozen_string_literal: true

class People < ApplicationRecord
  before_validation :downcase_fields

  belongs_to :account

  belongs_to :nationality, dependent: :destroy

  has_one :assistant, dependent: :destroy

  has_one :patient, dependent: :destroy

  has_one :doctor, dependent: :destroy

  has_many :documents_people, dependent: :destroy
  has_many :people, through: :documents_people

  has_many :languages_people, dependent: :destroy
  has_many :languagues, through: :languages_people

  has_many :people_phones, dependent: :destroy
  has_many :phones, through: :people_phones

  has_many :addresses_people, dependent: :destroy
  has_many :addresses, through: :addresses_people

  has_many :attachments_people, dependent: :destroy
  has_many :attachments, through: :attachments_people

  validates :account, uniqueness: true

  validates :nationality, presence: true

  validates :first_name,
            format: { with: /[a-zA-Z]/ },
            length: { minimum: 2 },
            presence: { message: 'is required or invalid' }

  validates :last_name,
            format: { with: /[a-zA-Z]/ },
            length: { minimum: 2 },
            presence: { message: 'is required or invalid' }

  validates :birthdate,
            presence: { message: 'is required or invalid' }

  validates :gender,
            inclusion: {
              in: %w[
                female
                male
              ],
              message: 'is not valid'
            },
            presence: true

  def downcase_fields
    gender.downcase!
  end

  def full_name
    first_name + ' ' + last_name
  end

  def as_json
    {
      id: self.id,
      full_name: full_name,
      first_name: first_name,
      last_name: last_name,
      birthdate: birthdate,
      gender: gender,
      nationality: nationality.as_json,
      document: DocumentsPerson.where(person_id: id).as_json,
      phones: PeoplePhone.where(person_id: id).as_json,
      languages: LanguagesPerson.where(person_id: id).as_json
    }
  end
end
