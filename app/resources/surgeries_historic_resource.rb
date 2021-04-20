class SurgeriesHistoricResource < JSONAPI::Resource
  attributes :created_at, :surgery_name
  has_one :pathologicals_historic
  has_one :surgery

  def surgery_name
    @model.surgery.name
  end
end
