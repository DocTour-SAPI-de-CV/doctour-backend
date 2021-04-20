class DrugsHistoric < ApplicationRecord
  belongs_to :non_pathologicals_historic
  belongs_to :drug

  validates :non_pathologicals_historic,
            presence: true

  validates :drug,
            presence: true
end
