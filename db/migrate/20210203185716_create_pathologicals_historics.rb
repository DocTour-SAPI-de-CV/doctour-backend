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

      t.boolean :hypertension
      t.boolean :diabetes
      t.boolean :respiratory_disease
      t.boolean :allergy
      t.boolean :surgical_historic
      t.boolean :medicine

      t.timestamps
    end
  end
end
