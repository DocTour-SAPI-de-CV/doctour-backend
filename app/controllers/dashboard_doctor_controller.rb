# frozen_string_literal: true

class DashboardDoctorController < ApplicationController
  def show
    @dashboard_doctor = DashboardDoctorFinder.new(nil).find(params[:id])
    render(json: { dashboard_doctor: @dashboard_doctor })
  end
end
