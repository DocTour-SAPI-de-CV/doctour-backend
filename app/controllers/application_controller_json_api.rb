# frozen_string_literal: true

class ApplicationControllerJsonApi < ApplicationController
  include JSONAPI::ActsAsResourceController

  # def context
  #   { current_user: current_user }
  # end

  # before_action :authenticate_user
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :null_session
end
