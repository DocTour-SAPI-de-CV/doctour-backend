class NonPathologicalsHistoric < ApplicationRecord
  # has_many :drugs_historics, dependent: :destroy
  # has_many :drugs, through: :drugs_historics

  # has_many :vaccines_historics, dependent: :destroy
  # has_many :vaccines, through: :vaccines_historics


  belongs_to :patient

  validates :patient, presence: true
end
