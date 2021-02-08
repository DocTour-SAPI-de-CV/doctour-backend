# frozen_string_literal: true

class CreateAllergiesHistorics < ActiveRecord::Migration[6.0]
  def change
    create_table :allergies_historics, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.references :pathologicals_historic,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     on_update: :cascade,
                     on_delete: :cascade
                   }

      t.references :allergy,
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
