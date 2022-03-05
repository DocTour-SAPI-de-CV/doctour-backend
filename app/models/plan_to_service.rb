class PlanToService < ApplicationRecord
  belongs_to :plan
  belongs_to :service

end
