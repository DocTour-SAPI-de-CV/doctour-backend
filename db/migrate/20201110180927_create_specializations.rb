# frozen_string_literal: true

class CreateSpecializations < ActiveRecord::Migration[6.0]
  def change
    create_table :specializations, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string  :name,
                null: false,
                index: { unique: true }

      t.timestamps
    end
  end
end
