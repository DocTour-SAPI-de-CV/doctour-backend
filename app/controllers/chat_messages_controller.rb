class ChatMessagesController < ApplicationControllerJsonApi
  #skip_before_action :authenticate_user, only: [:create]

  def messages_from
    render json: messages_decorated
  end

  private

  def messages_decorated
    room.chat_messages.limit(20).map do |msg|
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
end
