class AttendanceRoom < ApplicationRecord
  belongs_to doctor
  belongs_to patient
  belongs_to interpret
end
