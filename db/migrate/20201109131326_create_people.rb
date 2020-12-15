# frozen_string_literal: true

class CreatePeople < ActiveRecord::Migration[6.0]
  enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
  def change
    create_table :people, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.date :birthdate, null: false
      t.string :gender, null: false

      t.references :account,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     on_update: :cascade,
                     on_delete: :cascade
                   },
                   index: { unique: true }

      t.references :nationality,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     on_update: :cascade,
                     on_delete: :cascade
                   },
                   index: { unique: false }

      t.timestamps
    end
  end
end
