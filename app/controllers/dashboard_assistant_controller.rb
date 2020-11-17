# frozen_string_literal: true

class DashboardAssistantController < ApplicationController
  def show
    @dashboard_assistant = DashboardAssistantFinder.new(nil).find
    render(json: { dashboard_assistant: @dashboard_assistant })
  end
end
