# frozen_string_literal: true

class CreateLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :languages, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :name,
               null: false,
               index: { unique: true }

      t.timestamps
    end
  end
end
