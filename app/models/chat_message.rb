class ChatMessage < ApplicationRecord
  default_scope { order(created_at: :asc).limit(20) }

  belongs_to :to, class_name: "User"
  belongs_to :from, class_name: "User"
  belongs_to :chat_room

  def username
    from.name
  end

  def category
    from&.account&.category
  end
end
