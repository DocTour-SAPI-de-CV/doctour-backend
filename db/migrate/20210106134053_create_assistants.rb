# frozen_string_literal: true

class CreateAssistants < ActiveRecord::Migration[6.0]
  def change
    create_table :assistants, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.references :person,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     to_table: :people,
                     on_update: :cascade,
                     on_delete: :cascade
                   }
      t.integer :status, null: false
      t.string :photo, null: false

      t.timestamps
    end
  end
end
