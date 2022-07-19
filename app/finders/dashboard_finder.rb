# frozen_string_literal: true

class DashboardFinder < ApplicationFinder
  def find
    {
      account_count: account_count,
      doctor_count: doctor_count,
      doctors_online_count: doctors_online_count,
      partner_count: partner_count,
      people_count: people_count,
      screening_count: screening_count,
      screening_today_count: screening_today_count,
      service_count: service_count,
      soap_count: soap_count
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

  def doctors_online_count
    Doctor.where(status: 1).count
  end

  def screening_today_count
    Screening.where(created_at: Date.today.all_day).count
  end
end
