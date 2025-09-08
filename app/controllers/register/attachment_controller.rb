# frozen_string_literal: true

CREATE = Register::CreateController
VERIFY = Register::VerificationController
DELETE = Register::DeleteController

module Register
  class AttachmentController < ApplicationController
    def initialize
      @objects = {}
      @stop = false
    end

    def result(content)
      if content[:object]
        hash = { "#{content[:object].class.name}": content[:object] }
        @objects.merge!(hash)
      end

      @message = content[:message]
      @status = content[:status]

      DELETE.objects(@objects) if content[:flag]

      @stop = true if content[:flag]
    end

    def create
      upload_url = StorageAdapter.upload(
        params[:file],
        "attachments/#{params[:person_patient_id]}_#{SecureRandom.hex(10)}"
      )
      result(CREATE.attachment(upload_url, params[:file_name]))
      result(CREATE.attachment_person(@objects[:Attachment], params)) unless @stop

      render(json: @message, status: @status)
    end

    def delete
      attachment = Attachment.find(params[:id])

      file_path = extract_file_path_from_url(attachment.file)
      StorageAdapter.delete(file_path)

      render(json: attachment.delete )
    end
  end
end
