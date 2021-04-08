# frozen_string_literal: true

class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
    puts "Usuario conectado: #{current_user}"
  end

  def send_message(data)
    from = current_user.id
    to =data["to"]
    message = data["message"]
  end
end
