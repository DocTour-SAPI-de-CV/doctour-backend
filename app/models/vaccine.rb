class Vaccine < ApplicationRecord
  has_many :vaccines_historics, dependent: :destroy
  has_many :non_pathologicals_historics, through: :vaccines_historics

  validates :name,
            length: { in: 3..72 },
            presence: true
end
