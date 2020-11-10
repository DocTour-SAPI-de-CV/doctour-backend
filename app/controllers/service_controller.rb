# frozen_string_literal: true

class ServiceController < ApplicationController
  include ErrorSerializer

  # rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { service: Service.all })
  end

  def index
    render(json: { service: Service.find(params[:id]) })
  end

  def create
    service = Service.new(service_params)
    render(json: { service: service }) if service.save

    render(json: { error: service.errors }) unless service.save
  end

  def delete
    @service = Service.find(params[:id])
    @service.destroy!
    render(json: { "service_id deleted": params[:id] })
  end

  def update
    service = Service.find(params[:id])
    render(json: { service: service }) if service.update(service_params)

    render(json: { error: service.errors }) unless service.update(service_params)
  end

  private

  def service_params
    params.require(:service).permit(:name, :price, :description)
  end
end
