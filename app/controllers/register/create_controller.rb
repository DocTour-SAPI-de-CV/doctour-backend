# frozen_string_literal: true

VERIFY = Register::VerificationController
module Register
  class CreateController < ApplicationController
    def self.user(params)
      password = if params[:password].nil?
                   Devise.friendly_token.first(32)
                 else
                   params[:password]
                 end

      user = User.new(
        email: params[:email],
        password: password
      )
      begin
        user.save!

        VERIFY.result({ object: user, flag: false, status: :created })
      rescue ActiveRecord::RecordInvalid
        if User.exists?(email: params[:email])
          VERIFY.result({ object: user, flag: true, status: :conflict })
        else
          VERIFY.result({ object: user, flag: true, status: :unprocessable_entity })
        end
      end
    end

    def self.account(user, category)
      account = Account.new(user_id: user.id, category: category)
      begin
        account.save!

        VERIFY.result({ object: account, flag: false })
      rescue ActiveRecord::RecordInvalid
        VERIFY.result({ object: account, flag: true, status: :unprocessable_entity })
      end
    end

    def self.people(account, params)
      people = People.new(
        account_id: account.id,
        first_name: params[:first_name],
        last_name: params[:last_name],
        birthdate: params[:birthdate],
        gender: params[:gender],
        nationality_id: params[:nationality_id]
      )
      begin
        people.save!

        VERIFY.result({ object: people, flag: false })
      rescue ActiveRecord::RecordInvalid
        VERIFY.result({ object: people, flag: true, status: :unprocessable_entity })
      end
    end

    def self.language(person, language)
      language_person = LanguagesPerson.new(
        language_id: language[:id],
        person_id: person.id,
        native: language[:native]
      )
      begin
        language_person.save!

        VERIFY.result({ object: language_person, flag: false })
      rescue ActiveRecord::RecordInvalid
        VERIFY.result({ object: language_person, flag: true, status: :unprocessable_entity })
      end
    end

    def self.specialization(specialization, doctor)
      specialization_doctor = DoctorsSpecialization.new(
        specialization_id: specialization,
        doctor_id: doctor.id
      )
      begin
        specialization_doctor.save!

        VERIFY.result({ object: specialization_doctor, flag: false })
      rescue ActiveRecord::RecordInvalid
        VERIFY.result({ object: specialization_doctor, flag: true, status: :unprocessable_entity })
      end
    end

    def self.document(params)
      document = Document.new(
        document_type: params[:document_type],
        number: params[:document_number]
      )
      begin
        document.save!

        VERIFY.result({ object: document, flag: false })
      rescue ActiveRecord::RecordInvalid
        VERIFY.result({ object: document, flag: true, status: :unprocessable_entity })
      end
    end

    def self.document_person(document, person)
      document_person = DocumentsPerson.new(
        document_id: document.id,
        person_id: person.id
      )
      begin
        document_person.save!

        VERIFY.result({ object: document_person, flag: false })
      rescue ActiveRecord::RecordInvalid
        VERIFY.result({ object: document_person, flag: true, status: :unprocessable_entity })
      end
    end

    def self.phone(params)
      phone = Phone.new(
        country_code: params[:country_code],
        area_code: params[:area_code],
        number: params[:phone_number]
      )
      begin
        phone.save!

        VERIFY.result({ object: phone, flag: false })
      rescue ActiveRecord::RecordInvalid
        VERIFY.result({ object: phone, flag: true, status: :unprocessable_entity })
      end
    end

    def self.person_phone(person, phone)
      person_phone = PeoplePhone.create(
        phone_id: phone.id,
        person_id: person.id
      )
      begin
        person_phone.save!

        VERIFY.result({ object: person_phone, flag: false })
      rescue ActiveRecord::RecordInvalid
        VERIFY.result({ object: person_phone, flag: true, status: :unprocessable_entity })
      end
    end

    def self.address(params)
      address = Address.new(
        street: params[:street],
        street_number: params[:street_number],
        zipcode: params[:zipcode],
        country: params[:country],
        city: params[:city],
        state: params[:state]
      )
      begin
        address.save!

        VERIFY.result({ object: address, flag: false })
      rescue ActiveRecord::RecordInvalid
        VERIFY.result({ object: address, flag: true, status: :unprocessable_entity })
      end
    end

    def self.address_person(address, person)
      address_person = AddressesPerson.new(
        address_id: address.id,
        person_id: person.id
      )
      begin
        address_person.save!

        VERIFY.result({ object: address_person, flag: false })
      rescue ActiveRecord::RecordInvalid
        VERIFY.result({ object: address_person, flag: true, status: :unprocessable_entity })
      end
    end

    def self.doctor(person, params)
      doctor = Doctor.new(
        person_id: person.id,
        photo: 'foto.png',
        about: params[:about],
        status: 0
      )

      # falta colocar upload foto AWS

      begin
        doctor.save!

        VERIFY.result({ object: doctor, flag: false })
      rescue ActiveRecord::RecordInvalid
        VERIFY.result({ object: doctor, flag: true, status: :unprocessable_entity })
      end
    end

    def self.assistant(person)
      assistant = Assistant.new(
        person_id: person.id,
        photo: 'foto.png',
        status: 0
      )

      # falta colocar upload foto AWS

      begin
        assistant.save!

        VERIFY.result({ object: assistant, flag: false })
      rescue ActiveRecord::RecordInvalid
        VERIFY.result({ object: assistant, flag: true, status: :unprocessable_entity })
      end
    end

    def self.patient(person, request)
      patient = Patient.new(
        person_id: person.id,
        photo: 'foto.png',
        privacy_policy: true,
        terms_use: true,
        client_ip: request.remote_ip
      )
      begin
        patient.save!

        VERIFY.result({ object: patient, flag: false })
      rescue ActiveRecord::RecordInvalid
        VERIFY.result({ object: patient, flag: true, status: :unprocessable_entity })
      end
    end

    def self.attachment(file, file_name)
      attachment = Attachment.new(file: file, file_name: file_name)
      begin
        attachment.save!

        VERIFY.result({ object: attachment, flag: false })
      rescue ActiveRecord::RecordInvalid
        VERIFY.result({ object: attachment, flag: true, status: :unprocessable_entity })
      end
    end

    def self.attachment_person(attachment, params)
      attachment_person = AttachmentsPerson.new(
        attachment_id: attachment.id,
        person_doctor_id: params[:person_doctor_id],
        person_patient_id: params[:person_patient_id],
        attachment_type_id: params[:attachment_type_id]
      )

      puts attachment_person.errors.as_json

      begin
        attachment_person.save!

        VERIFY.result({ object: attachment_person, flag: false })
      rescue ActiveRecord::RecordInvalid
        VERIFY.result({ object: attachment_person, flag: true, status: :unprocessable_entity })
      end
    end
  end
end
