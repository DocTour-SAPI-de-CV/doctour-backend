class AllergyResource < JSONAPI::Resource
  attributes :name, :created_at
  has_one :allergies_historic, foreign_key_on: :related
end
