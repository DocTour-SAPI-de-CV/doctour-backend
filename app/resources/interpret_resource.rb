class InterpretResource < JSONAPI::Resource
  attributes :first_name, :last_name, :email, :created_at
  has_many :languages
  has_many :addresses
  has_many :phones
  has_one :interpreter_availability
end
