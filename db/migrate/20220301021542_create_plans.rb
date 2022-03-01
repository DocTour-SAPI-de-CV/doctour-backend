class CreatePlans < ActiveRecord::Migration[6.0]
  enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
  def change
    create_table :plans, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :desctiption

      t.timestamps
    end
  end
end
