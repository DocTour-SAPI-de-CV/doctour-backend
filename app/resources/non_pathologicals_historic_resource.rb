class NonPathologicalsHistoricResource < JSONAPI::Resource
  attributes :patient_id, :alcoholic_beverages, :drugs, :tobacco_wallets, :vaccines, :created_at

  has_many :vaccines_historics
  has_many :drugs_historics
  has_one :patient
end
