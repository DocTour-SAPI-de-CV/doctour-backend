# frozen_string_literal: true

class AttachmentController < ApplicationController
  before_action :authenticate_user, except: :show

  include ErrorSerializer

  rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    attachments = Attachment.joins(attachments_people: :attachment_type).where(params[:person_patient_id]).select("attachments.*, attachment_types.*, attachments_people.*")
    render(json: { attachments: attachments })
  end
end
