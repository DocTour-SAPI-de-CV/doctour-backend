# frozen_string_literal: true

class CreateLanguagesPeople < ActiveRecord::Migration[6.0]
  def change
    create_table :languages_people, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.references :language,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     on_update: :cascade,
                     on_delete: :cascade
                   }
      t.references :person,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     on_update: :cascade,
                     on_delete: :cascade
                   }
      t.boolean :native, null: false

      t.timestamps
    end
  end
end
