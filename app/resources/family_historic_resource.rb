class FamilyHistoricResource < JSONAPI::Resource
  attributes :history_family_illnesses, :side_family, :mother_side, :father_side

  has_one :patient
end
