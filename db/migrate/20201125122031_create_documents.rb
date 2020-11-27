# frozen_string_literal: true

class CreateDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :documents, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :document_type, null: false
      t.string :number, null: false

      t.index %i[document_type number], unique: true

      t.timestamps
    end
  end
end
