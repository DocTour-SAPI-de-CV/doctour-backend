class WaitingRoomChannel < ApplicationCable::Channel
  @@waiting_room_queue = Concurrent::Array.new

  def subscribed
    if current_user.account.category == "patient"
      if not @@waiting_room_queue.include? current_user
        @@waiting_room_queue << { user: current_user, interpret: nil }
      end
      stream_for current_user
    elsif ["doctor", "assistant"].include? current_user.account.category
      stream_for "assistant_and_doctors"
      stream_for current_user
    end

    broadcast_user_list
  end

  def unsubscribed
    #find e delete
    @@waiting_room_queue.delete_if { |current_item| current_item.user == current_user }

    broadcast_user_list
  end

  def take
    return unless current_user.account.category == "doctor"
    next_patient = @@waiting_room_queue.shift().user
    #instanciar service room
    #enviar para doutor, e paciente (com esse id gerado eles vao conseguir acessar)
    broadcast_to(next_patient, { "service_room_id": "asdfghjkljhgfdsdfghj" })
    broadcast_to(current_user, { "service_room_id": "asdfghjkljhgfdsdfghj" })
    #enviar email para interpret com chave
  end

  def set_interpret(data)
    # find user (data.patient_id)
    # find interpret (data.interpret_id)
    # setar interpret na fila na estrutura

  end

  def broadcast_user_list
    broadcast_to("assistant_and_doctors", { users_count: @@waiting_room_queue.count, users_list: @@waiting_room_queue })
  end
end
