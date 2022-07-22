class CreateFamilyHistorics < ActiveRecord::Migration[6.0]
  def change
    create_table :family_historics, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.references :patient,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                    on_update: :cascade,
                    on_delete: :cascade
                   }

      t.boolean :history_family_illnesses
      t.string  :side_family
      t.text    :mother_side
      t.text    :father_side
      
      t.timestamps
    end
  end
end
