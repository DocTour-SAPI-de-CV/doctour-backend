class DrugResource < JSONAPI::Resource
  attributes :name, :created_at
  has_one :vaccines_historics, foreign_key_on: :related
end
