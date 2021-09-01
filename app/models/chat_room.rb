class ChatRoom < ApplicationRecord
    belongs_to :service_room, optional: true
    has_many :chat_messages
    has_many :user_chat_rooms
    has_many :users, through: :user_chat_rooms
end
