# frozen_string_literal: true

class CreatePhonesInterprets < ActiveRecord::Migration[6.0]
  def change
    create_table :phones_interprets, id: :uuid, default: 'gen_random_uuid()' do |t|
      
      t.references :interpret,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     on_update: :cascade,
                     on_delete: :cascade
                   }
      t.references :phone,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     on_update: :cascade,
                     on_delete: :cascade
                   }

      t.timestamps
    end
  end
end
