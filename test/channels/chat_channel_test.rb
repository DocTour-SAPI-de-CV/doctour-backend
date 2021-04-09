require "test_helper"

class ChatChannelTest < ActionCable::Channel::TestCase
  def test_speak
    user_from = User.first
    user_to = User.second

    stub_connection current_user: user_to
    subscribe

    stub_connection current_user: user_from
    subscribe

    assert_broadcast_on(user_to, { message: "Hello, Rails!", from_id: user_from.id }) do
      a = perform :send_message, to: user_to.id, message: "Hello, Rails!"
    end
  end
end
