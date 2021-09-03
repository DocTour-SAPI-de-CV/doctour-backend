require 'test_helper'

class ChatRoomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @chat_room = chat_rooms(:one)
  end

  test "should get index" do
    get chat_rooms_url, as: :json
    assert_response :success
  end

  test "should create chat_room" do
    assert_difference('ChatRoom.count') do
      post chat_rooms_url, params: { chat_room: { id: @chat_room.id, kind: @chat_room.kind, name: @chat_room.name } }, as: :json
    end

    assert_response 201
  end

  test "should show chat_room" do
    get chat_room_url(@chat_room), as: :json
    assert_response :success
  end

  test "should update chat_room" do
    patch chat_room_url(@chat_room), params: { chat_room: { id: @chat_room.id, kind: @chat_room.kind, name: @chat_room.name } }, as: :json
    assert_response 200
  end

  test "should destroy chat_room" do
    assert_difference('ChatRoom.count', -1) do
      delete chat_room_url(@chat_room), as: :json
    end

    assert_response 204
  end
end
