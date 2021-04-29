class CreateServiceRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :service_rooms, id: :uuid, default: "gen_random_uuid()" do |t|
      t.uuid :doctor_id
      t.uuid :patient_id
      t.uuid :interpret_id
      t.string :interpret_access_key
      t.timestamp :finished_at

      t.timestamps
    end
  end
end
