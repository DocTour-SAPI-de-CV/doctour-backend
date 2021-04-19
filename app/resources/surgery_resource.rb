class SurgeryResource < JSONAPI::Resource
  attribute :name
  has_one surgeries_historics
end
