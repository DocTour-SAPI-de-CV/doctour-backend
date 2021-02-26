class Drug < ApplicationRecord
  has_many :drugs_historics, dependent: :destroy
  has_many :non_pathologicals_historics, through: :drugs_historics

  validates :name,
            length: { in: 3..72 },
            presence: true
end
