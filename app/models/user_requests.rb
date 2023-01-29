# frozen_string_literal: true

class UserRequests < ApplicationRecord
  validates :description,
            presence: true

  validates :user_id,
            presence: true
end
