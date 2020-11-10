# frozen_string_literal: true

class Account < ApplicationRecord
  before_validation :downcase_fields

  has_one :user, dependent: :destroy

  validates :category,
            inclusion: {
              in: %w[
                admin
                client
                doctor
                assistant
              ],
              message: 'is not valid'
            },
            presence: true

  def downcase_fields
    category.downcase!
  end
end
