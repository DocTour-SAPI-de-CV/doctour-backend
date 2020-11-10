# frozen_string_literal: true

class CreateSubjectivesSoaps < ActiveRecord::Migration[6.0]
  def change
    create_table :subjectives_soaps, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.references :subjective,
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

      t.index %i[soap_id subjective_id],
              unique: true,
              name: 'index_soap_subjectives'

      t.timestamps
    end
  end
end
