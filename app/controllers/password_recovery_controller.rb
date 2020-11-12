class PasswordRecoveryController < ApplicationController
  before_action :authenticate_user!, only: [:recovery]

  include ErrorSerializer

  rescue_from ActionController::ParameterMissing, with: :missing_params

	def index
		PasswordMailerSender.send_email(email)
			
		head(:no_content)
	end

	def recovery
		@user = User.find(id)
		@user.update_attributes(password: new_password)
	end

	private
	def email
		params.require(:email)
	end

	def id
		params.require(:id)
	end

	def new_password
		params.require(:password)
	end
end