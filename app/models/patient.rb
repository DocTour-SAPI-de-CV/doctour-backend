# frozen_string_literal: true

class Patient < ApplicationRecord
  belongs_to :people

  validates :people, uniqueness: true

  validates :privacy_polity,
            inclusion: { in: [true],
                         message: 'You need to accept the Privacy Polity terms!' },
            presence: true

  validates :terms_use,
            inclusion: { in: [true],
                         message: 'You need to accept the terms of use!' },
            presence: true
end
