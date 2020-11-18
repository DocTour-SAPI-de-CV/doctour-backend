# frozen_string_literal: true

class Account < ApplicationRecord
  before_validation :downcase_fields

  belongs_to :user, dependent: :destroy

  has_one :people, dependent: :destroy

  validates :user, uniqueness: true

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
    category&.downcase!
  end
end
