class PatientResource < JSONAPI::Resource
  key_type :uuid
  attributes :client_ip, :photo, :privacy_policy, :terms_use
  has_one :pathologicals_historic
end
