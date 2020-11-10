# frozen_string_literal: true

class ObjectivesSoap < ApplicationRecord
  belongs_to :objective
  belongs_to :soap

  validates :objective,
            presence: true

  validates :soap,
            presence: true
end
