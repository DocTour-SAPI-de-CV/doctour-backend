class CreateInterpreterAvailabilities < ActiveRecord::Migration[6.0]
  enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

  def change
    create_table :interpreter_availabilities, id: :uuid, default: 'gen_random_uuid()' do |t|

      t.datetime :availability_in, null: false
      t.datetime :availability_out, null: false
      t.references :interprets, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
