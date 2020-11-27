# frozen_string_literal: true

class CreateAddressesPartners < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses_partners, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.references :partner,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     on_update: :cascade,
                     on_delete: :cascade
                   }

      t.references :address,
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
