# frozen_string_literal: true

class CreateAddressesInterprets < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses_interprets, id: :uuid, default: 'gen_random_uuid()' do |t|
      
      t.references :address,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     on_update: :cascade,
                     on_delete: :cascade
                   }
      t.references :interpret,
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
