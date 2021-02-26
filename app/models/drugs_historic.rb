class DrugsHistoric < ApplicationRecord
  belongs_to :non_pathologicals_historic
  belongs_to :medicine

  validates :non_pathologicals_historic,
            presence: true

  validates :drug,
            presence: true
end
