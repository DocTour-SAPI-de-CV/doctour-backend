# frozen_string_literal: true

class Account < ApplicationRecord
  
  has_one :user, dependent: :destroy

  validates :category,
            presence: true
end
