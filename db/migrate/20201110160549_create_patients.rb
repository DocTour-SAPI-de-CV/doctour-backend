# frozen_string_literal: true

class CreatePatients < ActiveRecord::Migration[6.0]
  def change
    create_table :patients, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :photo
      t.boolean :privacy_polity, null: false
      t.boolean :terms_use, null: false
      t.cidr :client_ip, null: false

      t.references :person,
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
