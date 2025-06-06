# frozen_string_literal: true

class Language < ApplicationRecord
  before_validation :downcase_fields

  has_many :languages_people, dependent: :destroy
  has_many :people, through: :languages_people

  has_many :languages_interprets, dependent: :destroy
  has_many :interprets, through: :languages_interprets

  validates :name,
            uniqueness: { case_sensitive: false },
            format: { with: /[a-zA-Z]/ },
            length: { in: 3..72 },
            presence: true

  def downcase_fields
    name&.downcase!
  end
end
