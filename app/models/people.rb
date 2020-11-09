# frozen_string_literal: true

class People < ApplicationRecord
  before_validation :downcase_fields

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
    self.gender.downcase!
  end
end
