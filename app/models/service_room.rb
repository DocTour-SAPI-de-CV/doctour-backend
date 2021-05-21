class ServiceRoom < ApplicationRecord
  belongs_to doctor
  belongs_to patient
  belongs_to interpret
  default_scope { where(finished_at: nil) }
end
