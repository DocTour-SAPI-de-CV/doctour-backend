# frozen_string_literal: true

class People < ApplicationRecord
  before_validation :downcase_fields

  belongs_to :account

  has_one :patient, dependent: :destroy

  has_one :doctor, dependent: :destroy

  has_many :languages_people, dependent: :destroy
  has_many :languague, through: :languages_people

  has_many :people_phones, dependent: :destroy
  has_many :phones, through: :people_phones

  has_many :addresses_people, dependent: :destroy
  has_many :addresses, through: :addresses_people

  validates :account, uniqueness: true

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
            length: { minimum: 2 },
            presence: { message: 'is required or invalid' }

  def downcase_fields
    gender.downcase!
  end

  def full_name
    first_name + ' ' + last_name
  end
end
