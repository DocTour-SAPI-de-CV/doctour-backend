# frozen_string_literal: true

class Interpret < ApplicationRecord
  has_many :addresses_interprets, dependent: :destroy
  has_many :address, through: :addresses_interprets

  has_many :languages_interprets, dependent: :destroy
  has_many :languages, through: :languages_interprets

  has_many :phones_interprets, dependent: :destroy
  has_many :phones, through: :phones_interprets

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            email: true
  validates :first_name,
            format: { with: /[a-zA-Z]/ },
            length: { minimum: 2 },
            presence: { message: 'is required or invalid' }
  validates :last_name,
            format: { with: /[a-zA-Z]/ },
            length: { minimum: 2 },
            presence: { message: 'is required or invalid' }
end
