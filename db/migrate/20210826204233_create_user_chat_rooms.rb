class CreateUserChatRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :user_chat_rooms do |t|
      t.uuid :user_id
      t.uuid :chat_room_id
    end
  end
end
