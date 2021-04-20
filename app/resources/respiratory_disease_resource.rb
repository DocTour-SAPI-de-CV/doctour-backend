class RespiratoryDiseaseResource < JSONAPI::Resource
  attributes :name, :created_at
  has_one :respiratories_historic, foreign_key_on: :related
end
