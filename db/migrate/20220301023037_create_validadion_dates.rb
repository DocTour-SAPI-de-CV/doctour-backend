class CreateValidadionDates < ActiveRecord::Migration[6.0]
  enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
  def change
    create_table :validadion_dates, id: :uuid, default: 'gen_random_uuid()' do |t|
     
      t.date :chekIn, null: false
      t.date :chekOut, null: false
      t.references :plan_to_services, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
