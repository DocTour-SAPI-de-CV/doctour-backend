# frozen_string_literal: true

class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
    Rails.logger.info "Usuario conectado: #{current_user.email}"
  end

  ##
  # send_message
  # metodo ao ser chamado envia mensagem e persiste no banco de dados
  # parametros:
  # [to] o id do usuario qual vai ser enviado a mensagem
  # [message] a mensagem a ser enviada
  def send_message(data)
    from = current_user
    to = User.find(data["to"])
    message = data["message"]
    cm = ChatMessage.create!(message: message, from: from, to: to)
    broadcast_to(to, { message: message, from_id: from.id })
    Rails.logger.info "Mensage enviada de: #{from.email}, para: #{to.email}, mensagem: #{message}"
  end

  ##
  # read
  # define as mensagens nao lidas de um determinado usuário como lidas
  # [from] usuario de qual a mensagem foi enviada
  def read(data)
    from = User.find(data["from"])
    current_user.received_messages.where(from_id: from.id).where(readed: false).update_all(readed: true)
  end
end
