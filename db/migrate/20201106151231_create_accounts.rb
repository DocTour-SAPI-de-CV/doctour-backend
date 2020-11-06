# frozen_string_literal: true

class CreateAccounts < ActiveRecord::Migration[6.0]
  enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
  def change
    create_table :accounts, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :category,
               null: false

      t.timestamps
    end
  end
end
