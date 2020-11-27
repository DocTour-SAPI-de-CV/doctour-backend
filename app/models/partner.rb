# frozen_string_literal: true

class Partner < ApplicationRecord
  has_many :partners_phones, dependent: :destroy
  has_many :phones, through: :partners_phones

  has_many :addresses_partners, dependent: :destroy
  has_many :addresses, through: :addresses_partners

  has_many :documents_partners, dependent: :destroy
  has_many :documents, through: :documents_partners

  validates :name,
            length: { in: 3..72 },
            presence: true

  validates :responsible_name,
            format: { with: /[a-zA-Z]/ },
            length: { in: 3..72 },
            presence: true
end
