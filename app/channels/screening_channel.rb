class ScreeningChannel < ApplicationCable::Channel
  def subscribed
    Rails.logger.info "dentro do subscribed \n\n"

    stream_from 'screening:new_screening'
  end

  def test
    Rails.logger.info "dentro do test \n\n"
  end
end
