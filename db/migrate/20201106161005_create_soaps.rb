# frozen_string_literal: true

class CreateSoaps < ActiveRecord::Migration[6.0]
  def change
    create_table :soaps, id: :uuid do |t|
      t.text :subjective
      t.text :objective
      t.text :assessment, null: false
      t.text :plan, null: false
      t.binary :medical_description, limit: 3.megabyte
      t.binary :medical_report, limit: 3.megabyte
      t.text :observation

      t.timestamps
    end
  end
end
