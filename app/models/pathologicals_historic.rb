# frozen_string_literal: true

class PathologicalsHistoric < ApplicationRecord
  has_many :allergies_historics, dependent: :destroy
  has_many :allergies, through: :allergies_historics

  has_many :surgeries_historics, dependent: :destroy
  has_many :surgeries, through: :surgeries_historics

  has_many :medicines_historics, dependent: :destroy
  has_many :medicines, through: :medicines_historics

  has_many :respiratories_historics, dependent: :destroy
  has_many :respiratory_diseases, through: :respiratories_historics

  belongs_to :patient

  validates :patient, uniqueness: true

  validates :hypertension, presence: true
  validates :diabetes, presence: true
  validates :respiratory_disease, presence: true
  validates :allergy, presence: true
  validates :surgical_historic, presence: true
  validates :medicine, presence: true
end
