class PatientResource < JSONAPI::Resource
  attribute :client_ip,:photo, :privacy_polity 2 2
boolean 1 7
terms_use 2 2
boolean 1 7
  has_one surgeries_historics
end
