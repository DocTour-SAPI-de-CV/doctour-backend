# frozen_string_literal: true

class LanguagesInterpret < ApplicationRecord
  belongs_to :language
  belongs_to :interpret

  validates :language,
            presence: true

  validates :interpret,
            presence: true
end
