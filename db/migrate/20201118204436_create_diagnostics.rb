# frozen_string_literal: true

class CreateDiagnostics < ActiveRecord::Migration[6.0]
  def change
    create_table :diagnostics, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :code,
               null: false,
               index: { unique: true }

      t.string :name,
               null: false

      t.timestamps
    end
  end
end
