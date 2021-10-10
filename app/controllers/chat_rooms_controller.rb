class ChatRoomsController < ApplicationController
  before_action :set_chat_room, only: %i[ show update destroy ]

  # GET /chat_rooms
  # GET /chat_rooms.json
  def index
    render json: {
      username: @current_user.name,
      chat_rooms: decorated_chat_rooms
    }
  end

  # GET /chat_rooms/1
  # GET /chat_rooms/1.json
  def show
    render json: decorated_chat_room
  end

  # POST /chat_rooms
  # POST /chat_rooms.json
  def create
    @chat_room = ChatRoom.new(chat_room_params)

    if @chat_room.save
      render json: chat_room_params
    else
      render json: @chat_room.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /chat_rooms/1
  # PATCH/PUT /chat_rooms/1.json
  def update
    if @chat_room.update(chat_room_params)
      render :show, status: :ok, location: @chat_room
    else
      render json: @chat_room.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chat_rooms/1
  # DELETE /chat_rooms/1.json
  def destroy
    @chat_room.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_chat_room

    @chat_room = chat_rooms.find(params[:id])
  end

  def chat_rooms
    @chat_rooms = ChatRoom.joins(:user_chat_rooms).where(user_chat_rooms: {user: @current_user})
  end

  # Only allow a list of trusted parameters through.
  def chat_room_params
    params.require(:chat_room).permit(:id, :name, :kind)
  end

  def chat_messages
    @chat_messages ||= @chat_room.chat_messages
  end

  def decorated_chat_rooms
    chat_rooms.map do |room|
      room.attributes.except("created_at", "service_room_id")
    end
  end

  def decorated_chat_room
    chatmessages = @chat_room.chat_messages.map do |msg|
      username = msg.username
      category = msg.category
      msg = msg.attributes

      msg["user"] = username
      msg["category"] = category
      msg["key"] = msg['id']

      msg
    end
    {
      chatMessages: chatmessages,
      name: @chat_room.name,
      kind: @chat_room.kind,
      id: @chat_room.id
    }
  end
end
