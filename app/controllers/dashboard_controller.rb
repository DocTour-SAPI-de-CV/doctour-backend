# frozen_string_literal: true

class DashboardController < ApplicationController
  def show
    @dashboard = DashboardFinder.new(nil).find
    render(json: { dashboard: @dashboard }) 
  end
end
