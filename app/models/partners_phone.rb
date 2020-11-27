# frozen_string_literal: true

class PartnersPhone < ApplicationRecord
  belongs_to :partner
  belongs_to :phone

  validates :partner,
            presence: true

  validates :phone,
            presence: true
end
