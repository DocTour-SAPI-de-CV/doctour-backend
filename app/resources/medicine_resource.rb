class MedicineResource < JSONAPI::Resource
  attribute :name
  has_one :medicines_historic
end
