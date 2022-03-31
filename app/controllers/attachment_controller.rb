# frozen_string_literal: true

class AttachmentController < ApplicationController
  before_action :authenticate_user, except: :show

  include ErrorSerializer

  rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    
    person_patient_id = params[:person_patient_id]
    attachments = ActiveRecord::Base.connection.execute(
      "SELECT * FROM public.attachments 
      INNER JOIN attachments_people 
      ON attachments_people.attachment_id = attachments.id
      INNER JOIN attachment_types
      on attachments_people.attachment_type_id = attachment_types.id
      where person_patient_id = '#{person_patient_id}'"
    ).to_a[0]

    render(json: { attachments: attachments })
  end
end

