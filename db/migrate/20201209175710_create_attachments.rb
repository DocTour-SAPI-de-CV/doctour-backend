# frozen_string_literal: true

class CreateAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :attachments, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :file, null: false
      t.string :file_name, null: false

      t.timestamps
    end
  end
end
