# frozen_string_literal: true

class AttachmentTypeController < ApplicationController
  before_action :authenticate_user, except: :show

  include ErrorSerializer

  rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    attachment_types = AttachmentType.all
    puts(params[:user_type])
    attachment_types = attachment_types.filter { |att| att.create.include? params[:user_type] } if params[:user_type]
    render(json: { attachment_types: attachment_types })
  end
end
