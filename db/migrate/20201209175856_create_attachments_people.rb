# frozen_string_literal: true

class CreateAttachmentsPeople < ActiveRecord::Migration[6.0]
  def change
    create_table :attachments_people, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.references :attachment,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     on_update: :cascade,
                     on_delete: :cascade
                   }
      t.references :person_patient,
                   type: :uuid,
                   null: true,
                   foreign_key: {
                     to_table: :people,
                     on_update: :cascade,
                     on_delete: :cascade
                   }
      t.references :person_doctor,
                   type: :uuid,
                   null: true,
                   foreign_key: {
                     to_table: :people,
                     on_update: :cascade,
                     on_delete: :cascade
                   }
      t.references :person_assistant,
      type: :uuid,
      null: true,
      foreign_key: {
        to_table: :people,
        on_update: :cascade,
        on_delete: :cascade
      }
      t.references :attachment_type,
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
