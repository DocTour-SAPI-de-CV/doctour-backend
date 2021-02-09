# frozen_string_literal: true

class CreateAllergies < ActiveRecord::Migration[6.0]
  def change
    create_table :allergies, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :name

      t.timestamps
    end
  end
end
