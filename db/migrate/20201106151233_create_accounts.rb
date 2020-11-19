# frozen_string_literal: true

class CreateAccounts < ActiveRecord::Migration[6.0]
  enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
  def change
    create_table :accounts, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :category,
               null: false

      t.references :user,
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
