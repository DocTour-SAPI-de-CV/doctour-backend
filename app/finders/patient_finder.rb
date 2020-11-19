# frozen_string_literal: true

class PatientFinder < ApplicationFinder
  def find(id)
    @patient = Patient.find(id)

    info
  end

  def info
    {
      name: @patient.full_name,
      email: @patient.email,
      ip: @patient.client_ip.to_s,
      created_at: @patient.created_at_mask,
      privaci_polity: @patient.privacy_polity,
      terms_use: @patient.terms_use
    }
  end
end
