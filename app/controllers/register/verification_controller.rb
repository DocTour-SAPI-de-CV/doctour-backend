# frozen_string_literal: true

module Register
  class VerificationController < ApplicationController
    def self.result(content)
      action = 'created'
      action = 'updated' if content[:update]
      if content[:flag]
        { message: {
          "#{content[:object].class.name}":
            content[:object].errors.full_messages
        },
          status: content[:status],
          object: content[:object],
          update: content[:update],
          flag: true }
      else
        { message: {
          success: "All have been #{action} :D"
        },
          status: content[:status],
          object: content[:object],
          flag: false }
      end
    end

    def self.master_authorization(request)
      auth = request.headers['Authorization'].split.last
      token = Rails.application.credentials.master_auth_key

      if token == auth
        { message: 'ok!', flag: false, status: :ok }
      else
        { message: 'Master password is wrong!',
          flag: true,
          status: :unauthorized }
      end
    end

    def self.check_category(category, check_category)
      if category == check_category
        { message: 'Category ok!', flag: false, status: :ok }
      else
        { message: "Only use this enpoint for #{check_category} register!",
          flag: true,
          status: :bad_request }
      end
    end
  end
end
