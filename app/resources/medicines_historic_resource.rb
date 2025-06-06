class MedicinesHistoricResource < JSONAPI::Resource
  attributes :created_at, :medicine_id, :pathologicals_historic_id
  has_one :pathologicals_historic
  has_one :medicine

  def medicine_name
    @model.medicine.name
  end
end
