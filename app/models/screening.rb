# frozen_string_literal: true

class Screening < ApplicationRecord
  # belongs_to :doctor
  belongs_to :patient

  has_one :soap, dependent: :destroy

  # validates :doctor,
            # presence: true

  validates :patient_id,
            presence: true

  validates :performed_at,
            presence: true

  validates :return,
            inclusion: { in: [true, false] }
  
  validates :reason_consultation,
            presence: true

  validates :bmi,
           presence: true

  def performed_date
    performed_at&.strftime('%m/%d/%Y')
  end

  def performed_hour
    performed_at&.strftime('%H:%M')
  end

  # def as_json
  #   {
  #     id: id,
  #     performed_date: performed_date,
  #     performed_hour: performed_hour,
  #     # patient_name: patient.full_name,
  #     return: self.return,
  #     # doctor_name: doctor.full_name,
  #     # doctor_document: doctor.doctor_document
  #   }
  # end

end
