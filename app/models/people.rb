# frozen_string_literal: true

class People < ApplicationRecord
  before_validation :downcase_fields

  belongs_to :account

  has_one :patient, dependent: :destroy

  has_one :doctor, dependent: :destroy

  has_many :people_phones, dependent: :destroy
  has_many :phones, through: :people_phones

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
end
