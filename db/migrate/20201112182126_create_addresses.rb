# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :street, null: false
      t.integer :street_number, null: false
      t.string :zipcode, null: false
      t.string :country, null: false
      t.string :city, null: false
      t.string :state, null: false

      t.timestamps
    end
  end
end
