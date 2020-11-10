# frozen_string_literal: true

class Soap < ApplicationRecord
  validates :assessment,
            format: { with: /[a-zA-Z]/ },
            length: { in: 3..300 },
            presence: true

  validates :plan,
            format: { with: /[a-zA-Z]/ },
            length: { in: 3..300 },
            presence: true

  validates :subjective,
            length: { in: 3..300 }

  validates :objective,
            length: { in: 3..300 }

  validates :observation,
            length: { in: 3..300 }

  validates :medical_report,
            length: { in: 3..300 }

  validates :medical_description,
            length: { in: 3..300 }
end
