# frozen_string_literal: true

class CreatePathologicalsHistorics < ActiveRecord::Migration[6.0]
  def change
    create_table :pathologicals_historics, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.references :patient,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     on_update: :cascade,
                     on_delete: :cascade
                   }

      t.boolean :hypertension, null: false
      t.boolean :diabetes, null: false
      t.boolean :respiratory_disease, null: false
      t.boolean :allergy, null: false
      t.boolean :surgical_historic, null: false
      t.boolean :medicine, null: false

      t.timestamps
    end
  end
end
