# frozen_string_literal: true

class DoctorController < ApplicationController
  include ErrorSerializer

  # rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { doctor: Doctor.all })
  end

  def index
    render(json: { doctor: Doctor.find(params[:id]) })
  end

  def create
    doctor = Doctor.new(doctor_params)
    render(json: { doctor: doctor }) if doctor.save

    render(json: { error: doctor.errors }) unless doctor.save
  end

  def delete
    @doctor = Doctor.find(params[:id])
    @doctor.destroy!
    render(json: { "doctor_id deleted": params[:id] })
  end

  def update
    doctor = Doctor.find(params[:id])
    render(json: { doctor: doctor }) if doctor.update(doctor_params)

    render(json: { error: doctor.errors }) unless doctor.update(doctor_params)
  end

  private

  def doctor_params
    params.require(:doctor).permit(:person_id, :photo, :about)
  end
end
