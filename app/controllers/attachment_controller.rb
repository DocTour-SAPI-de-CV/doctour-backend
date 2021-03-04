# frozen_string_literal: true

class AttachmentController < ApplicationController
  before_action :authenticate_user, except: :show

  include ErrorSerializer

  rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    attachments = Attachment.joins(:attachments_people).where(params[:person_patient_id])
    render(json: { attachments: attachments })
  end
end
