class ValidationDate < ApplicationRecord
  belongs_to :PlanToService
  belongs_to :User
end
