class VaccinesHistoric < ApplicationRecord
  belongs_to :non_phatologicals_historic
  belongs_to :vaccine

  validates :non_pathologicals_historic,
            presence: true

  validates :vaccine,
            presence: true
end
