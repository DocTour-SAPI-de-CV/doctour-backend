class CreatePlans < ActiveRecord::Migration[6.0]
  enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
  def change
    create_table :plans, id: :integer do |t|
      t.string :description

      t.timestamps
    end
  end
end
