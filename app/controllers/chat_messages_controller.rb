class ChatMessagesController < ApplicationControllerJsonApi
  #skip_before_action :authenticate_user, only: [:create]

  def unreaded_messages_from_user
    @chat_messages = ChatMessage.where(chat_room: @current_user.chat_rooms).where(readed: false).where.not(from: @current_user.id)

    render json: messages_decorated
  end

  def messages_from_others
    @chat_messages = chat_messages.where(readed: false).where.not(from: @current_user.id)

    render json: messages_decorated
  end

  def messages_from
    @chat_messages = chat_messages.limit(20)
    render json: messages_decorated
  end

  private

  def messages_decorated
    chat_messages.map do |msg|
      username = msg.username
      category = msg.category
      msg = msg.attributes

      msg["user"] = username
      msg["category"] = category
      msg["key"] = "#{msg['id']}#{msg['from_id']}"

      msg
    end
  end

  def room
    @current_user.chat_rooms.find(params[:room_id])
  end

  def chat_messages
    @chat_messages ||= room.chat_messages
  end
end
