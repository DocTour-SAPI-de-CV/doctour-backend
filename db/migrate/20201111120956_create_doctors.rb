# frozen_string_literal: true

class CreateDoctors < ActiveRecord::Migration[6.0]
  def change
    create_table :doctors, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.references :person,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     on_update: :cascade,
                     on_delete: :cascade
                   },
                   index: { unique: true }

      t.binary :photo, null: false, limit: 3.megabyte
      t.text :about, null: false
      t.integer :status

      t.timestamps
    end
  end
end
