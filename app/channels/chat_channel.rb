class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_for params[:room_id]
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
    message = data["message"]
    cm = ChatMessage.create!(message: message, from: from, to: from, chat_room_id: data["room_id"])
    broadcast_to(params[:room_id], [{ message: message, from_id: from.id , user: cm.username, key: cm.id }])
    Rails.logger.info "Mensagem enviada de: #{from.email}, para: #{to.email}, mensagem: #{message}"
  end

  ##
  # read_messages
  # define as mensagens nao lidas de um determinado usuário como lidas
  # [from] usuario de qual a mensagem foi enviada
  def read_messages(data)
    from = User.find(data["from"])
    current_user.received_messages.where(from_id: from.id).where(readed: false).update_all(readed: true)
  end

end
