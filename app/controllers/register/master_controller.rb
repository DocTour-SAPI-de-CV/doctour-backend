# frozen_string_literal: true

CREATE = Register::CreateController
VERIFY = Register::VerificationController
DELETE = Register::DeleteController

module Register
  class MasterController < ApplicationController
    skip_before_action :authenticate_user

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
      result(VERIFY.check_category(params[:category], 'master'))
      result(VERIFY.master_authorization(request)) unless @stop

      result(CREATE.user(params)) unless @stop
      result(CREATE.account(@objects[:User], 'master')) unless @stop
      result(CREATE.people(@objects[:Account], params)) unless @stop
      result(CREATE.document(params)) unless @stop
      result(CREATE.document_person(@objects[:Document], @objects[:People])) unless @stop
      result(CREATE.phone(params)) unless @stop
      result(CREATE.person_phone(@objects[:People], @objects[:Phone])) unless @stop

      unless @stop
        WelcomeMailer.with(email: @objects[:User].email, full_name: @objects[:People].full_name).send_email.deliver_later
      end
      render(json: @message, status: @status)
    end
  end
end
