class CreateChatRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_rooms, id: :uuid do |t|
      t.string :name, null:false
      t.string :kind, null:false
      t.uuid :service_room_id

      t.timestamps
    end
  end
end
