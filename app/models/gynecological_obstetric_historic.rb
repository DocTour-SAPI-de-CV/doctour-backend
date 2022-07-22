class GynecologicalObstetricHistoric < ApplicationRecord
  belongs_to :patient

  validates :patient, uniqueness: true
end
