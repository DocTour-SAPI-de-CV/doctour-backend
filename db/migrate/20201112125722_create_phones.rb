# frozen_string_literal: true

class CreatePhones < ActiveRecord::Migration[6.0]
  def change
    create_table :phones, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :country_code, null: false
      t.string :area_code, null: false
      t.string :number, null: false

      t.timestamps
    end
  end
end
