# frozen_string_literal: true

class CreateObjectivesSoaps < ActiveRecord::Migration[6.0]
  def change
    create_table :objectives_soaps, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.references :objective,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     on_update: :cascade,
                     on_delete: :cascade
                   }

      t.references :soap,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     on_update: :cascade,
                     on_delete: :cascade
                   }

      t.index %i[soap_id objective_id],
              unique: true,
              name: 'index_soap_objectives'

      t.timestamps
    end
  end
end
