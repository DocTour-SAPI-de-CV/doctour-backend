# frozen_string_literal: true

CREATE = Register::CreateController
UPDATE = Register::UpdateController
VERIFY = Register::VerificationController
DELETE = Register::DeleteController

module Register
  class PatientController < ApplicationController
    before_action :authenticate_user, except: :create

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
      # result(VERIFY.check_category(params[:category], 'patient'))
      unless @stop
        user = CREATE.user(params)
        result(user)
      end
      result(CREATE.account(@objects[:User], 'patient')) unless @stop
      result(CREATE.people(@objects[:Account], params)) unless @stop
      result(CREATE.document(params)) unless @stop
      result(CREATE.document_person(@objects[:Document], @objects[:People])) unless @stop
      result(CREATE.phone(params)) unless @stop
      result(CREATE.person_phone(@objects[:People], @objects[:Phone])) unless @stop
      params[:languages].each do |language|
        result(CREATE.language(@objects[:People], language)) unless @stop
      end
      result(CREATE.patient(@objects[:People], request)) unless @stop

      unless @stop
        WelcomeMailer.with(email: @objects[:User].email, full_name: @objects[:People].full_name).send_email.deliver
      end
      render(json: @message, status: @status)
    end

    def update
      user = User.find(params[:id])
      # result(VERIFY.check_category(user.account.category, 'patient'))
      result(UPDATE.patient(params, user)) unless @stop

      render(json: @message, status: @status)
    end

    def show
      accounts = Account.where(category: 'patient').all
      patients = accounts.map do |account|
        account.user.as_json
      end

      render json: patients, status: :ok
    end

    def summary
      accounts = Account.where(category: 'patient').all
      patients = accounts.map do |account|
        account.user.patient_summary
      end

      render json: patients, status: :ok
    end

    def medical_histories
      accounts = Account.where(category: 'patient').all
      medical_histories = accounts.map do |account|
        account.user.medical_history[0]
      end

      render json: medical_histories, status: :ok
    end

    def medical_history
      user = User.find(params[:id])

      render json: user.medical_history, status: :ok
    end

    def find_user
      @user = User.find_user(params[:email])
      render(json: { user: @user } )
    end
  end
end
