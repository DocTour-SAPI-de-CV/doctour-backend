# frozen_string_literal: true

class CreateMedicinesHistorics < ActiveRecord::Migration[6.0]
  def change
    create_table :medicines_historics, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.references :pathologicals_historic,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     on_update: :cascade,
                     on_delete: :cascade
                   }

      t.references :medicine,
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
