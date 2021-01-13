# frozen_string_literal: true

class AttachmentTypeController < ApplicationController
  before_action :authenticate_user, except: :show

  include ErrorSerializer

  rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { attachment_types: AttachmentType.all })
  end
end
