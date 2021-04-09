# frozen_string_literal: true

class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
    Rails.logger.info "Usuario conectado: #{current_user.email}"
  end

  def send_message(data)
    from = current_user
    to = User.find(data["to"])
    message = data["message"]
    cm = ChatMessage.create!(message: message, from: from, to: to)
    broadcast_to(to, { message: message, from_id: from.id })
    Rails.logger.info "Mensage enviada de: #{from.email}, para: #{to.email}, mensagem: #{message}"
  end
end
