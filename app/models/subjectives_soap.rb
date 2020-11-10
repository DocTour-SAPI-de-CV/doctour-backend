# frozen_string_literal: true

class SubjectivesSoap < ApplicationRecord
  belongs_to :subjective
  belongs_to :soap

  validates :subjective,
            presence: true

  validates :soap,
            presence: true
end
