# frozen_string_literal: true

class SpecializationController < ApplicationController
  include ErrorSerializer

  def show
    render(json: { specialization: Specialization.all })
  end

  def index
    render(json: { specialization: Specialization.find(params[:id]) })
  end

  def create
    specialization = Specialization.new(spec_params)
    render(json: { specialization: specialization }) if specialization.save

    render(json: { error: specialization.errors }) unless specialization.save
  end

  def delete
    @specialization = Specialization.find(params[:id])
    @specialization.destroy!
    render(json: { "specialization_id deleted": params[:id] })
  end

  def update
    specialization = Specialization.find(params[:id])
    render(json: { specialization: specialization }) if specialization.update(spec_params)

    render(json: { error: specialization.errors }) unless specialization.update(spec_params)
  end

  private

  def spec_params
    params.require(:specialization).permit(:name)
  end
end
