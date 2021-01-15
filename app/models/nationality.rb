# frozen_string_literal: true

class Nationality < ApplicationRecord
  before_validation :downcase_fields

  has_one :people, dependent: :destroy

  validates :name,
            uniqueness: { case_sensitive: false },
            format: { with: /[a-zA-Z]/ },
            length: { in: 3..72 },
            presence: true

  def downcase_fields
    name&.downcase!
  end

  def as_json
    {
      id: id,
      name: name
    }
  end
end
