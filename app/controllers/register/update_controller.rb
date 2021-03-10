# frozen_string_literal: true

VERIFY = Register::VerificationController

module Register
  class UpdateController < ApplicationController
    def self.address(params, user)
      address = AddressesPerson.find_by(person: user.account.people).address
      begin
        address.update!(
          street: params[:street],
          street_number: params[:street_number],
          zipcode: params[:zipcode],
          country: params[:country],
          city: params[:city],
          state: params[:state]
        )

        VERIFY.result({ object: address, update: true, flag: false })
      rescue ActiveRecord::RecordInvalid
        VERIFY.result({ object: address, update: true, flag: true, status: :unprocessable_entity })
      end
    end

    def self.assistant(params, user)
      assistant = Assistant.find_by(person: user.account.people)
      if params[:photo]
        upload_url = AwsS3.upload(
          params[:photo],
          "assistants_photos/#{user.id}_photo.png"
        )
      end
      begin
        assistant.update!(
          photo: upload_url
        )

        VERIFY.result({ object: assistant, update: true, flag: false })
      rescue ActiveRecord::RecordInvalid
        VERIFY.result({ object: assistant, update: true, flag: true, status: :unprocessable_entity })
      end
    end

    def self.doctor(params, user)
      doctor = Doctor.find_by(person: user.account.people)
      if params[:photo]
        upload_url = AwsS3.upload(
          params[:photo],
          "doctors_photos/#{user.id}_photo.png"
        )
      end
      begin
        doctor.update!(
          photo: upload_url,
          about: params[:about]
          status: params[:status]
        )

        VERIFY.result({ object: doctor, update: true, flag: false })
      rescue ActiveRecord::RecordInvalid
        VERIFY.result({ object: doctor, update: true, flag: true, status: :unprocessable_entity })
      end
    end
  end
end
