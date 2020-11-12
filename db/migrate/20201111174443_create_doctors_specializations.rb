# frozen_string_literal: true

class CreateDoctorsSpecializations < ActiveRecord::Migration[6.0]
  def change
    create_table :doctors_specializations, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.references :doctor,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     on_update: :cascade,
                     on_delete: :cascade
                   }

      t.references :specialization,
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
