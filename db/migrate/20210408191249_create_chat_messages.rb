class CreateChatMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_messages do |t|
      t.text :message
      t.references :to, null: false, type: :uuid, foreign_key: { to_table: :users }
      t.references :from, null: false, type: :uuid, foreign_key: { to_table: :users }
      t.boolean :readed, default: false

      t.timestamps
    end
  end
end
