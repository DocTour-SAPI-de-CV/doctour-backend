# frozen_string_literal: true

class DoctorsStatusFinder < ApplicationFinder
  def find
    {
      0 => status_0,
      1 => status_1,
      2 => status_2,
      all: all
    }
  end

  private

  def status_0
    @doctors = Doctor.where(status: 0)
    @results = []
    @doctors.each do |doctor|
      @results << {
        name: doctor.full_name,
        id: doctor.id
      }
    end

    @results
  end

  def status_1
    @doctors = Doctor.where(status: 1)
    @results = []
    @doctors.each do |doctor|
      @results << {
        name: doctor.full_name,
        id: doctor.id
      }
    end

    @results
  end

  def status_2
    @doctors = Doctor.where(status: 2)
    @results = []
    @doctors.each do |doctor|
      @results << {
        name: doctor.full_name,
        id: doctor.id
      }
    end

    @results
  end

  def all
    @doctors = Doctor.all
    @results = []
    @doctors.each do |doctor|
      @results << {
        name: doctor.full_name,
        id: doctor.id
      }
    end

    @results
  end
end
