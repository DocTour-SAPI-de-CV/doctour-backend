class NonPathologicalsHistoricResource < JSONAPI::Resource
  attributes :patient_id, :alcoholic_beverages, :drugs, :drugs_name, :tobacco_wallets, :vaccines, :vaccines_name, :created_at

  # has_many :vaccines_historics
  # has_many :drugs_historics
  has_one :patient
end
