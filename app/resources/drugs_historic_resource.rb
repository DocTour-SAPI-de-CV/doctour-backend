class DrugsHistoricResource < JSONAPI::Resource
  attributes :created_at, :quantity, :drug_name
  has_one :non_pathologicals_historic
  has_one :drug

  def drug_name
    @model.drug.name
  end
end
