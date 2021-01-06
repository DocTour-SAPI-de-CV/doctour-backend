# frozen_string_literal: true

class AssistantController < ApplicationController
  include ErrorSerializer

  # rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { assistant: Assistant.all })
  end

  def index
    render(json: { assistant: Assistant.find(params[:id]) })
  end

  def create
    assistant = Assistant.new(assistant_params)
    render(json: { assistant: assistant }) if assistant.save

    render(json: { error: assistant.errors }) unless assistant.save
  end

  def delete
    @assistant = Assistant.find(params[:id])
    @assistant.destroy!
    render(json: { "assistant_id deleted": params[:id] })
  end

  def update
    assistant = Assistant.find(params[:id])
    render(json: { assistant: assistant }) if assistant.update(assistant_params)

    render(json: { error: assistant.errors }) unless assistant.update(assistant_params)
  end

  private

  def assistant_params
    params.require(:assistant).permit(:first_name, :last_name, :email)
  end
end
