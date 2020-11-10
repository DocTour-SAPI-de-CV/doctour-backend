class CreatePatients < ActiveRecord::Migration[6.0]
  def change
    create_table :patients, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.boolean :privacy_polity, null: false
      t.boolean :terms_use, null: false

      t.references :people,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     on_update: :cascade,
                     on_delete: :cascade
                   },
                   index: { unique: true }

      t.timestamps
    end
  end
end
