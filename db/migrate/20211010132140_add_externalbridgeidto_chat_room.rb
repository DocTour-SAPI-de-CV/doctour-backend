class AddExternalbridgeidtoChatRoom < ActiveRecord::Migration[6.0]
  def change
    add_column :chat_rooms, :external_bridge_id, :string
  end
end
