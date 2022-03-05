class CreatePlanToServices < ActiveRecord::Migration[6.0]
  enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
  def change
    create_table :plan_to_services, id: :integer do |t|
      
      t.integer :quantity
      t.references :plans, type: :integer ,null: false, foreign_key: true
      t.references :services, type: :integer, null: false, foreign_key: true
      

      t.timestamps
    end
  end
end
