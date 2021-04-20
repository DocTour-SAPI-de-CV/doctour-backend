class MedicinesHistoricResource < JSONAPI::Resource
  attributes :created_at, :medicine_name
  has_one :pathologicals_historic
  has_one :medicine

  def medicine_name
    @model.medicine.name
  end
end
