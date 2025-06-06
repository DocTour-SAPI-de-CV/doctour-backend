# frozen_string_literal: true

CREATE = Register::CreateController
UPDATE = Register::UpdateController
VERIFY = Register::VerificationController
DELETE = Register::DeleteController

module Register
  class DoctorController < ApplicationController
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

      if content[:flag]
        DELETE.objects(@objects) unless content[:update]
      end

      @stop = true if content[:flag]
    end

    def create
      result(VERIFY.check_category(params[:category], 'doctor'))

      params[:password] = SecureRandom.alphanumeric(16)
      params[:nationality_id] = params[:nationality_id] || ENV['DEFAULT_NATIONALITY_ID']
      

      result(CREATE.user(params)) unless @stop

      result(CREATE.account(@objects[:User], 'doctor')) unless @stop
      result(CREATE.people(@objects[:Account], params)) unless @stop
      result(CREATE.document(params)) unless @stop
      result(CREATE.document_person(@objects[:Document], @objects[:People])) unless @stop
      # result(CREATE.phone(params)) unless @stop
      # result(CREATE.person_phone(@objects[:People], @objects[:Phone])) unless @stop
      # params[:languages].each do |language|
      language = {id: Language.first.id, native: true }
      
      result(CREATE.language(@objects[:People], language)) unless @stop
      # end
      logger.debug @objects
      result(CREATE.address(params)) unless @stop
      result(CREATE.address_person(@objects[:Address], @objects[:People])) unless @stop
      result(CREATE.doctor(@objects[:People], params)) unless @stop
      # params[:specializations].each do |specialization|
      specialization_id = params[:specialization_id] || ENV['DEFAULT_SPECIALIZATION_ID']  
      result(CREATE.specialization(specialization_id, @objects[:Doctor])) unless @stop
      # end
      
      

      unless @stop
        WelcomeMailer.with(email: @objects[:User].email, full_name: @objects[:People].full_name).send_email.deliver
      end
      render(json: @message, status: @status)
    end

    def delete
      result(VERIFY.check_category(params[:category], 'doctor'))
      # user = User.find(params[:id]).delete
      # logger.debug "------------------------"
      # logger.debug params
      User.find(params[:id]).delete


      render json: {info:'user deleted'}, status: :ok
    end



    def update
      user = User.find(params[:id])
      result(VERIFY.check_category(user.account.category, 'doctor'))

      if user.have_address?
        result(CREATE.address(params)) unless @stop
        result(CREATE.address_person(@objects[:Address], user.account.people)) unless @stop
      else
        result(UPDATE.address(params, user)) unless @stop
        result(UPDATE.doctor(params, user)) unless @stop
      end

      render(json: @message, status: @status)
    end

    def show
      accounts = Account.where(category: 'doctor').all
      doctors = accounts.map do |account|
        account.user.as_json
      end

      render json: doctors, status: :ok
    end
  end
end
