class MedicineResource < JSONAPI::Resource
  attributes :name, :created_at
  has_one :medicines_historic
end
