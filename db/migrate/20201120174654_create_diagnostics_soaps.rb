class CreateDiagnosticsSoaps < ActiveRecord::Migration[6.0]
  def change
    create_table :diagnostics_soaps, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.references :soap,
      type: :uuid,
      null: false,
      foreign_key: {
        on_update: :cascade,
        on_delete: :cascade
      }
      t.references :diagnostic,
      type: :uuid,
      null: false,
      foreign_key: {
        on_update: :cascade,
        on_delete: :cascade
      }
      t.boolean :primary
      t.text :observation

      t.timestamps
    end
  end
end
