# frozen_string_literal: true

class Service < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false }

  validates :price,
            presence: true
end
