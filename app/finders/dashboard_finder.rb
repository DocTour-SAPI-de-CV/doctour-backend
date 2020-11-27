# frozen_string_literal: true

class DashboardFinder < ApplicationFinder
  def find
    {
      people_count: people_count,
      service_count: service_count,
      screening_count: screening_count,
      soap_count: soap_count,
      doctor_count: doctor_count,
      partner_count: partner_count,
      account_count: account_count
    }
  end

  private

  def people_count
    People.count
  end

  def service_count
    Service.count
  end

  def screening_count
    Screening.count
  end

  def soap_count
    Soap.count
  end

  def doctor_count
    Doctor.count
  end

  def partner_count
    Partner.count
  end

  def account_count
    Account.count
  end
end
