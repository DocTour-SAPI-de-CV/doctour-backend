# frozen_string_literal: true

class AttachmentController < ApplicationController
  before_action :authenticate_user, except: :show

  include ErrorSerializer

  rescue_from ActionController::ParameterMissing, with: :missing_params

  def index
    attachment_people = AttachmentPeople.where(params[:person_patient_id])
    attachments = Attachment.joins(:attachment_people)
    render(json: { attachments: attachments })
  end
end
