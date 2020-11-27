# frozen_string_literal: true

class CreateDocumentsPartners < ActiveRecord::Migration[6.0]
  def change
    create_table :documents_partners, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.references :partner,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     on_update: :cascade,
                     on_delete: :cascade
                   }

      t.references :document,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     on_update: :cascade,
                     on_delete: :cascade
                   }

      t.index %i[document_id partner_id], unique: true

      t.timestamps
    end
  end
end
