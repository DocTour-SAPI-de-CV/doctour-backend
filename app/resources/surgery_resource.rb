class SurgeryResource < JSONAPI::Resource
  attributes :name, :created_at
  has_one :surgeries_historics
end
