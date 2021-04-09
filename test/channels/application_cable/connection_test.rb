# frozen_string_literal: true

require "test_helper"

module ApplicationCable
  class ConnectionTest < ActionCable::Connection::TestCase
    test "connects with token" do
      user = User.first

      token, _ = Warden::JWTAuth::UserEncoder.new.call user, nil, nil

      connect params: { token: token }
      assert_equal(user, connection.current_user, "Usuario logou no ActionCable com sucesso")
      assert_not_equal(User.second, connection.current_user, "Usuario diferente")
    end
  end
end
