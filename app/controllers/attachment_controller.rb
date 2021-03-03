# frozen_string_literal: true

class AttachmentController < ApplicationController
  before_action :authenticate_user, except: :show

  include ErrorSerializer

  rescue_from ActionController::ParameterMissing, with: :missing_params

  def index
    render(json: { Attachment.joins(:attachments_people).where(params[:person_patient_id]) })
  end

end