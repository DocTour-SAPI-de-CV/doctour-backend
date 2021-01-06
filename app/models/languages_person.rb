# frozen_string_literal: true

class LanguagesPerson < ApplicationRecord
  belongs_to :language
  belongs_to :person, class_name: 'People'

  validates :person,
            presence: true

  validates :language,
            presence: true

  validates :native,
            inclusion: { in: [true, false],
                         message: 'Must be true or false!' }
end
