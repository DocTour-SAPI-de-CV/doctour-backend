class WaitingRoomChannel < ApplicationCable::Channel
  @@waiting_room_queue = Concurrent::Array.new

  def subscribed
    if current_user.account.category == "patient"
      @@waiting_room_queue << current_user 
      stream_for current_user
    else
      if ["doctor", "assistant"].include? current_user.account.category
        stream_for "assistant_and_doctors"
      end
    end
    puts @@waiting_room_queue
    broadcast_user_list
    
  end

  def unsubscribed
    @@waiting_room_queue.delete(current_user)
    puts @@waiting_room_queue
    broadcast_user_list
  end

  def pick
    return unless current_user.account.category == "doctor"
    next_patient = @@waiting_room_queue.shift()
    broadcast_to(next_patient, { "service_room_id": "asdfghjkljhgfdsdfghj" })
  end

  def broadcast_user_list
  broadcast_to("assistant_and_doctors", {users_list: @@waiting_room_queue })
  end
end
