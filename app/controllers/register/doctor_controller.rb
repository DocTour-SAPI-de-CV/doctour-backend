# frozen_string_literal: true

CREATE = Register::CreateController
VERIFY = Register::VerificationController
DELETE = Register::DeleteController

module Register
  class DoctorController < ApplicationController
    before_action :admin_authorization

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
      result(VERIFY.check_category(params[:category], 'doctor'))

      result(CREATE.user(params)) unless @stop
      result(CREATE.account(@objects[:User], 'doctor')) unless @stop
      result(CREATE.people(@objects[:Account], params)) unless @stop
      result(CREATE.document(params)) unless @stop
      result(CREATE.document_person(@objects[:Document], @objects[:People])) unless @stop
      result(CREATE.phone(params)) unless @stop
      result(CREATE.person_phone(@objects[:People], @objects[:Phone])) unless @stop
      params[:languages].each do |language|
        result(CREATE.language(@objects[:People], language)) unless @stop
      end
      result(CREATE.address(params)) unless @stop
      result(CREATE.address_person(@objects[:Address], @objects[:People])) unless @stop
      result(CREATE.doctor(@objects[:People], params)) unless @stop
      params[:specializations].each do |specialization|
        result(CREATE.specialization(specialization, @objects[:Doctor])) unless @stop
      end

      unless @stop
        WelcomeMailer.with(email: @objects[:User].email, full_name: @objects[:People].full_name).send_email.deliver_later
      end
      render(json: @message, status: @status)
    end
  end
end
