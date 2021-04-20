class MedicineResource < JSONAPI::Resource
  attributes :name, :created_at
  has_one :medicines_historic, foreign_key_on: :related
end
