class VaccinesHistoricResource < JSONAPI::Resource
  attributes :created_at, :vaccine_id, :non_pathologicals_historic_id
  has_one :non_pathologicals_historic
  has_one :vaccine

  def vaccine_name
    @model.vaccine.name
  end
end
