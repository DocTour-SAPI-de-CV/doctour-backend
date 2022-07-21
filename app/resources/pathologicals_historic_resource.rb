class PathologicalsHistoricResource < JSONAPI::Resource
  attributes :patient_id, :allergy,
             :diabetes, :hypertension,
             :medicine, :respiratory_disease,
             :surgical_historic, :created_at,
             :respiratory_disease_text, :allergy_text,
             :surgical_historic_text, :medicine_text

  # has_many :allergies_historics
  # has_many :surgeries_historics
  # has_many :medicines_historics
  # has_many :respiratories_historics
  has_one :patient
end
