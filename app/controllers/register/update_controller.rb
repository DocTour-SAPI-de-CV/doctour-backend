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
          about: params[:about],
          status: params[:status]
        )

        VERIFY.result({ object: doctor, update: true, flag: false })
      rescue ActiveRecord::RecordInvalid
        VERIFY.result({ object: doctor, update: true, flag: true, status: :unprocessable_entity })
      end
    end

    def self.patient(params, user)
      patient = Patient.find_by(person: user.account.people)
      if params[:photo]
        upload_url = AwsS3.upload(
          params[:photo],
          "patients_photos/#{user.id}_photo.png"
        )
      end
      begin
        patient.update!(
          photo: upload_url
        )

        VERIFY.result({ object: patient, update: true, flag: false })
      rescue ActiveRecord::RecordInvalid
        VERIFY.result({ object: patient, update: true, flag: true, status: :unprocessable_entity })
      end
    end

    def self.date_range(user,params)

      validation_data = ValidationDate.where(user_id: user.id)  
      begin
        
        validation_data.update(
          checkIn: params[:checkIn],
          checkOut: params[:checkOut],
          plan_id: params[:plan_id]
        )

        VERIFY.result({ object: validation_data, flag: false })
      rescue ActiveRecord::RecordInvalid
        VERIFY.result({ object: validation_data, flag: true, status: :unprocessable_entity })
      end
    end

    def self.search_user(params)
      

      begin
        user = User.where(email: params[:email]).first

        VERIFY.result({ object: user, flag: false })
      rescue ActiveRecord::RecordInvalid
        VERIFY.result({ object: user, flag: true, status: :unprocessable_entity })
      end
    end

    def self.pathological_history_update
      patient_history = Patient.where(patient_id: params[:id])

      respiratories_history = patient_history.respiratories_historics
      respiratories_history.respiratory_disease.update( params[:respiratory_disease] )

      
      begin

        patient_history.update(
          hypertension: params[:hypertension],
          diabetes: params[:diabetes],
          respiratory_disease: params[:respiratory_disease],
          allergy: params[:allergy],
          surgical_historic: params[:surgical_historic],
          medicine: params[:medicine]
        )
        
        VERIFY.result({ object: patient_history, flag: false })
      rescue ActiveRecord::RecordInvalid
        VERIFY.result({ object: patient_history, flag: true, status: :unprocessable_entity })
      end
      
    end

  end
end
