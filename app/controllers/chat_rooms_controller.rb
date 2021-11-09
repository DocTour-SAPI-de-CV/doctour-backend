class ChatRoomsController < ApplicationController
  before_action :set_chat_room, only: %i[ show update destroy ]
  before_action :set_chat_room_by_external_bridge, only: %i[add_doctor_to_chat patient_room]

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

  def patient_room
    add_doctor_to_chat
    render json: decorated_chat_room
  end

  # POST /chat_rooms
  # POST /chat_rooms.json
  def create
    @chat_room = ChatRoom.new(chat_room_params)

    if @chat_room.save
      UserChatRoom.create(chat_room: @chat_room, user: @current_user)
      render json: chat_room_params
    else
      render json: @chat_room.errors, status: :unprocessable_entity
    end
  end

  def find_or_create_chat_with_assistant
    assistant = Assistant.first.person.account.user
    puts assistant.name
    chat_room_with_assistant = @current_user.chat_rooms.joins(:users).where(users: {id: assistant}).first

    if !chat_room_with_assistant
      chat_room_with_assistant = ChatRoom.create({
        name: "Doctour assistant",
        kind: "Support chat",
        external_bridge_id: SecureRandom.uuid
      })
      UserChatRoom.create(chat_room: chat_room_with_assistant, user: @current_user)
      UserChatRoom.create(chat_room: chat_room_with_assistant, user: assistant)
    end

    render json: {room_id: chat_room_with_assistant.id}
  end

  def find_or_create_chat_with_patient
    patient = User.find(params[:id])
    chat_room_with_patient = @current_user.chat_rooms.joins(:users).where(users: {id: patient}).first

    if !chat_room_with_patient
      chat_room_with_patient = ChatRoom.create({
        name: "New chat",
        kind: "Chat created from doctor",
        external_bridge_id: SecureRandom.uuid
      })
      UserChatRoom.create(chat_room: chat_room_with_patient, user: @current_user)
      UserChatRoom.create(chat_room: chat_room_with_patient, user: patient)
    end

    render json: {room_id: chat_room_with_patient.id}
  end

  def add_doctor_to_chat
    UserChatRoom.create(chat_room: @chat_room, user: @current_user)
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
  def set_chat_room_by_external_bridge
    @chat_room ||= ChatRoom.find_by_external_bridge_id(params[:external_bridge_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_chat_room
    @chat_room = chat_rooms.find(params[:id])
  end

  def chat_rooms
    @chat_rooms ||= ChatRoom.joins(:user_chat_rooms).where(user_chat_rooms: {user: @current_user}).order(:created_at)
  end

  # Only allow a list of trusted parameters through.
  def chat_room_params
    params.require(:chat_room).permit(:id, :name, :kind, :external_bridge_id)
  end

  def chat_messages
    @chat_messages ||= @chat_room.chat_messages
  end

  def decorated_chat_rooms
    chat_rooms.uniq.map do |room|
      {
        chatMessages: [],
        name:  get_name_of_chat(room),
        kind: room.kind,
        id: room.id
      }
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
      name: get_name_of_chat(@chat_room),
      kind: @chat_room.kind,
      id: @chat_room.id,
      user_name: @current_user.name,
      user_id: @current_user.id,
      user_email: @current_user.email
    }
  end

  def get_name_of_chat(chat)
    if current_user_is_doctor?
      get_patient_from_chat(chat)
    elsif current_user_is_assistant?
      get_patient_from_chat(chat)
    elsif current_chat_is_with_doctor(chat)
      get_doctor_from_chat(chat)
    else
      get_assistant_from_chat(chat)
    end
  end

  def current_chat_is_with_doctor(chat)
    @current_chat_is_with_doctor ||= chat.users.joins(:account).where(accounts: {category: "doctor"}).first
  end

  def current_chat_is_with_assistant(chat)
    chat.users.joins(:account).where(accounts: {category: "assistant"}).first
  end

  def current_user_is_doctor?
    @current_user.account.category == "doctor"
  end

  def current_user_is_assistant?
    @current_user.account.category == "assistant"
  end

  def get_assistant_from_chat(chat)
    # name = chat.name == "New chat" ? "Doctour attendent" : chat.name
    # assistant_name = current_chat_is_with_assistant(chat).try(:name)

    # assistant_name || name
    chat.name
  end

  def get_doctor_from_chat(chat)
    name = chat.name == "New chat" ? "Doctor chat" : chat.name
    doctor_name = current_chat_is_with_doctor(chat).try(:name)

    doctor_name ? "Dr. #{doctor_name}" : name
  end

  def get_patient_from_chat(chat)
    name = chat.name == "New chat" ? "Patient chat" : chat.name
    patient_name = chat.users.joins(:account).where(accounts: {category: "patient"}).first.try(:name)

    patient_name || name
  end
end
