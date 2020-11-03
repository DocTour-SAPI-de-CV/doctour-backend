class CreateServices < ActiveRecord::Migration[6.0]
  enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

  def change
    create_table :services, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string  :name, 
                null: false,
                index: { unique: true }
      t.float :price, null: false
      t.text :description

      t.timestamps
    end
  end
end
