# frozen_string_literal: true

class DocumentsPerson < ApplicationRecord
  belongs_to :document
  belongs_to :person, class_name: 'People'

  validates :person,
            presence: true

  validates :document,
            presence: true
end
