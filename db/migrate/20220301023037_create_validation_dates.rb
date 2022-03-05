class CreateValidationDates < ActiveRecord::Migration[6.0]
  enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
  def change
    create_table :validation_dates, id: :uuid, default: 'gen_random_uuid()' do |t|
     
      t.date :checkIn, null: false
      t.date :checkOut, null: false
      t.references :plan_to_services, type: :integer, null: false, foreign_key: true
      t.references :user, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
