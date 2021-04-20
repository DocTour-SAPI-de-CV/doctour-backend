class CreateDrugsHistorics < ActiveRecord::Migration[6.0]
  def change
    create_table :drugs_historics, id: :uuid, default: "gen_random_uuid()" do |t|
      t.references :non_pathologicals_historic,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     on_update: :cascade,
                     on_delete: :cascade,
                   }
      t.references :drug,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     on_update: :cascade,
                     on_delete: :cascade,
                   }
      t.string :quantity

      t.timestamps
    end
  end
end
