# frozen_string_literal: true

class DashboardDoctorFinder < ApplicationFinder
  def find(doctor_id)
    {
      screenings_count: screenings_count(doctor_id),
      screenings: screenings(doctor_id),
      patients_waiting_room_count: patients_waiting_room_count
    }
  end

  private

  def screenings_count(doctor_id)
    Screening
      .left_joins(:doctor)
      .where('doctors.id = (?)', doctor_id)
      .count
  end

  def screenings(doctor_id)
    Screening
      .left_joins(:doctor)
      .where('doctors.id = (?)', doctor_id)
  end

  def patients_waiting_room_count
    'precisa de uma sala de espera primeiro'
  end
end
