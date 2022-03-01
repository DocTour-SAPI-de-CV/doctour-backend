class CreatePlanToServices < ActiveRecord::Migration[6.0]
  enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
  def change
    create_table :plan_to_services, id: :uuid, default: 'gen_random_uuid()' do |t|
      
      t.integer :quantity
      t.references :plans, type: :uuid ,null: false, foreign_key: true
      t.references :services, type: :uuid, null: false, foreign_key: true
      

      t.timestamps
    end
  end
end
