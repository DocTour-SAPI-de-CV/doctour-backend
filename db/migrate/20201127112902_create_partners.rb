# frozen_string_literal: true

class CreatePartners < ActiveRecord::Migration[6.0]
  def change
    create_table :partners, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :name, null: false
      t.string :responsible_name, null: false
      t.text :observation

      t.timestamps
    end
  end
end
