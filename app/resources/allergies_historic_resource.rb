class AllergiesHistoricResource < JSONAPI::Resource
  attributes :created_at, :allergy_id, :pathologicals_historic_id
  has_one :pathologicals_historic
  has_one :allergy
  
  def allergy_name
    @model.allergy.name
  end

  
end
