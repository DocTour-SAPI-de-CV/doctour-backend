class CreateNonPathologicalsHistorics < ActiveRecord::Migration[6.0]
  def change
    create_table :non_pathologicals_historics, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.references :patient,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     on_update: :cascade,
                     on_delete: :cascade
                   }
      t.boolean :drugs
      t.string  :drugs_name
      t.boolean :vaccines
      t.string  :vaccines_name
      t.boolean :alcoholic
      t.string  :alcoholic_beverages
      t.boolean :tobacco
      t.integer :tobacco_wallets

      t.timestamps
    end
  end
end
