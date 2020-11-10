# frozen_string_literal: true

class CreateSubjectives < ActiveRecord::Migration[6.0]
  def change
    create_table :subjectives, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string  :name,
                null: false,
                index: { unique: true }

      t.timestamps
    end
  end
end
