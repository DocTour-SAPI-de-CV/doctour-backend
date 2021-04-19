class SurgeryResource < JSONAPI::Resource
  attribute :name, :created_at
  has_one surgeries_historics
end
