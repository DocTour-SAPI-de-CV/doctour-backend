class RespiratoryDiseaseResource < JSONAPI::Resource
  attribute :name
  has_one :respiratories_historics
end
