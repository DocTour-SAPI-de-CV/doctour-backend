# frozen_string_literal: true

class PhonesInterpret < ApplicationRecord
  belongs_to :phone
  belongs_to :interpret

  validates :phone,
            presence: true

  validates :interpret,
            presence: true
end
