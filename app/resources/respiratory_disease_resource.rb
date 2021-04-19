class RespiratoryDiseaseResource < JSONAPI::Resource
  attributes :name, :created_at
  has_one :respiratories_historics
end
