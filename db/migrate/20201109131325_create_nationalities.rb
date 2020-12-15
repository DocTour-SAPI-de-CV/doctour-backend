# frozen_string_literal: true

class CreateNationalities < ActiveRecord::Migration[6.0]
  enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
  def change
    create_table :nationalities, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :name,
               null: false,
               index: { unique: true }

      t.timestamps
    end
  end
end
