# frozen_string_literal: true

class DoctorsStatusFinder < ApplicationFinder
  def find
    {
      0 => status_0,
      1 =>  status_1,
      2 => status_2,
      all: Doctor.all.ids
    }
  end

  private

  def status_0
    Doctor.where(status: 0).ids
  end

  def status_1
    Doctor.where(status: 1).ids
  end

  def status_2
    Doctor.where(status: 2).ids
  end
end
