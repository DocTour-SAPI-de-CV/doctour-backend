class RtcSessionChannel < ApplicationCable::Channel
  def subscribed
    stream_for "session_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def broadcast(data)
    broadcast_to "session_channel", data
  end

  private

  def session_params
    params.require(:session).permit(:type, :from, :to, :sdp, :candidate)
  end
end
