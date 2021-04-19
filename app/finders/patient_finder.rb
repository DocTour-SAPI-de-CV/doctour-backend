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
      privaci_policy: @patient.privacy_policy,
      terms_use: @patient.terms_use
    }
  end

  def find_name(name)
    name.downcase!
    name = '%' + name + '%'

    People
      .joins(:patient)
      .where(
        'LOWER(people.first_name) LIKE (?) or
        LOWER(people.last_name) LIKE (?)', name, name
      )
  end
end
