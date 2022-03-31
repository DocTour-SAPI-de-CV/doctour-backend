class InterpreterAvailabilityResource < JSONAPI::Resource
  attributes :name, :availability_in, :availability_out, :created_at
  has_one :interpret, foreign_key_on: :related
end
