class AddChatRoomToChatMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :chat_messages, :chat_room_id, :uuid, null:false
  end
end
