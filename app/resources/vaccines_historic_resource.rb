class VaccinesHistoricResource < JSONAPI::Resource
  attributes :created_at, :vaccine_name
  has_one :non_pathologicals_historic
  has_one :vaccine

  def vaccine_name
    @model.vaccine.name
  end
end
