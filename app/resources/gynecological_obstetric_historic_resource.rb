class GynecologicalObstetricHistoricResource < JSONAPI::Resource
  attributes :last_menstrual_cycle, :pregnancy, :number_pregnancies, :normal_deliveries,
             :cesarean_deliveries, :abortion, :contraceptive_methods

  has_one :patient
end
