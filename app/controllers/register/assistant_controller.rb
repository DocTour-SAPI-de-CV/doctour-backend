# frozen_string_literal: true

CREATE = Register::CreateController
UPDATE = Register::UpdateController
VERIFY = Register::VerificationController
DELETE = Register::DeleteController

module Register
  class AssistantController < ApplicationController
    before_action :admin_authorization, except: :update

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
      result(VERIFY.check_category(params[:category], 'assistant'))

      result(CREATE.user(params)) unless @stop
      result(CREATE.account(@objects[:User], 'assistant')) unless @stop
      result(CREATE.people(@objects[:Account], params)) unless @stop
      result(CREATE.document(params)) unless @stop
      result(CREATE.document_person(@objects[:Document], @objects[:People])) unless @stop
      result(CREATE.phone(params)) unless @stop
      result(CREATE.person_phone(@objects[:People], @objects[:Phone])) unless @stop
      params[:languages].each do |language|
        result(CREATE.language(@objects[:People], language)) unless @stop
      end
      # result(CREATE.address(params)) unless @stop
      # result(CREATE.address_person(@objects[:Address], @objects[:People])) unless @stop
      result(CREATE.assistant(@objects[:People])) unless @stop

      unless @stop
        WelcomeMailer.with(email: @objects[:User].email, full_name: @objects[:People].full_name).send_email.deliver_later
      end
      render(json: @message, status: @status)
    end

    def update
      user = User.find(params[:id])
      result(VERIFY.check_category(user.account.category, 'assistant'))

      if user.have_address?
        result(CREATE.address(params)) unless @stop
        result(CREATE.address_person(@objects[:Address], user.account.people)) unless @stop
      else
        result(UPDATE.address(params, user)) unless @stop
        result(UPDATE.assistant(params, user)) unless @stop
      end

      render(json: @message, status: @status)
    end

    def show
      accounts = Account.where(category: 'assistant').all
      assistants = accounts.map do |account|
        account.user.as_json
      end

      render json: assistants, status: :ok
    end
  end
end
