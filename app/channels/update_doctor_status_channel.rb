class UpdateDoctorStatusChannel < ApplicationCable::Channel
  def subscribed
    Rails.logger.info "dentro do subscribed status doctor \n\n"
    puts "Chamou \n\n"

    stream_from 'update_doctor_status'
  end

  def test
    Rails.logger.info "Channel update status Doctor \n\n"
  end
end
