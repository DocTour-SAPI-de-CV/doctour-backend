class RespiratoriesHistoricResource < JSONAPI::Resource
  attributes :created_at, :disease_name
  has_one :pathologicals_historic
  has_one :respiratory_disease

  def disease_name
    @model.respiratory_disease.name
  end
end
