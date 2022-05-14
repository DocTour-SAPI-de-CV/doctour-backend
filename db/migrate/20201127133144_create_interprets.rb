# frozen_string_literal: true

class CreateInterprets < ActiveRecord::Migration[6.0]
  def change
    create_table :interprets, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.string :languages, null: false
      t.text :available_times, null: false

      t.timestamps
    end
  end
end
