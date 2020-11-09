class CreatePeople < ActiveRecord::Migration[6.0]
  enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
  def change
    create_table :people, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthdate
      t.string :gender

      t.timestamps
    end
  end
end
