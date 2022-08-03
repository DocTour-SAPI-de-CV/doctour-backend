class CreateGynecologicalObstetricHistorics < ActiveRecord::Migration[6.0]
  def change
    create_table :gynecological_obstetric_historics, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.references :patient,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     on_update: :cascade,
                     on_delete: :cascade
                   }

      t.datetime :last_menstrual_cycle
      t.boolean  :pregnancy
      t.integer  :number_pregnancies
      t.integer  :normal_deliveries
      t.integer  :cesarean_deliveries
      t.boolean  :abortion
      t.integer  :number_abortion
      t.boolean  :contraceptive_methods

      t.timestamps
    end
  end
end
