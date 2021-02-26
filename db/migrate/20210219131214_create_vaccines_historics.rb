class CreateVaccinesHistorics < ActiveRecord::Migration[6.0]
  def change
    create_table :vaccines_historics, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.references :non_phatologicals_historic,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     on_update: :cascade,
                     on_delete: :cascade
                   }
      t.references :vaccine,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     on_update: :cascade,
                     on_delete: :cascade
                   }

      t.timestamps
    end
  end
end
