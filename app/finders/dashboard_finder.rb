# frozen_string_literal: true

class DashboardFinder < ApplicationFinder
  def find
    {
      people_count: people_count,
      service_count: service_count,
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

  def account_count
    Account.count
  end
end
