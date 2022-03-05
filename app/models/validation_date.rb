class ValidationDate < ApplicationRecord
  belongs_to :plan
  belongs_to :user
end
