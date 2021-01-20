# frozen_string_literal: true

class Screening < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  has_one :soap, dependent: :destroy

  validates :doctor,
            presence: true

  validates :patient,
            presence: true

  validates :performed_at,
            presence: true

  validates :return,
            inclusion: { in: [true, false] }

  validates :temperature,
            numericality: {
              only_float: true,
              greater_than_or_equal_to: 20,
              less_than_or_equal_to: 50
            }

  validates :heart_rate,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 240
            }

  validates :blood_pressure,
            format: { with: %r{([1-9]{1,1}[0-9]?/[1-9]{1,1}[0-9]?)} },
            length: { in: 3..5 }

  validates :weight,
            numericality: {
              only_float: true,
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 500
            },
            presence: true

  validates :height,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 23,
              less_than_or_equal_to: 240
            }

  def bmi
    height / (weight * weight)
  end

  def performed_date
    performed_at&.strftime('%m/%d/%Y')
  end
end
