# frozen_string_literal: true

class Account < ApplicationRecord
  validates :category,
            presence: true
end
