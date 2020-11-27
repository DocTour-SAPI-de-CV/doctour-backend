# frozen_string_literal: true

class DashboardAssistantFinder < ApplicationFinder
  def find
    {
      screenings_count: screenings_count,
      soaps_count: soaps_count,
      patients_waiting_room_count: patients_waiting_room_count,
      doctors_online_room: doctors_online_room
    }
  end

  private

  def screenings_count
    Screening.count
  end

  def soaps_count
    Soap.count
  end

  def patients_waiting_room_count
    'precisa de uma sala de espera primeiro'
  end

  def doctors_online_room
    'precisa de uma sala de espera primeiro'
  end
end
