# frozen_string_literal: true

class CreateScreenings < ActiveRecord::Migration[6.0]
  def change
    create_table :screenings, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.datetime :performed_at, null: false

      t.boolean :return, null: false

      t.references :patient,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     on_update: :cascade,
                     on_delete: :cascade
                   }

      t.float :temperature

      t.integer :heart_rate

      t.string :respiratory_frequency

      t.float :weight, null: false

      t.integer :height, null: false

      t.string :bmi

      t.timestamps
    end
  end
end
