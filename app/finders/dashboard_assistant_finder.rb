# frozen_string_literal: true

class DashboardAssistantFinder < ApplicationFinder
  def find
    {
      screenings_count: screenings_count,
      patients_waiting_room_count: patients_waiting_room_count,
      doctors_online_room: doctors_online_room
    }
  end

  private

  def screenings_count
    'precisa da tabela de screenings primeiro'
  end

  def patients_waiting_room_count
    'precisa de uma sala de espera primeiro'
  end

  def doctors_online_room
    'precisa de uma sala de espera primeiro'
  end
end
