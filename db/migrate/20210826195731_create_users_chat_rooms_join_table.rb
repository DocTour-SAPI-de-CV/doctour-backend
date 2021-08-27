class CreateUsersChatRoomsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :chat_rooms
  end
end
