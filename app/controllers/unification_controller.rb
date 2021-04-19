# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize, Lint/MissingCopEnableDirective

# render status
NOT_CREATED = 400
ALREADY_CREATED = 409
NOT_FOUND = 404
CREATED = 201

class UnificationController < ApplicationController
  before_action :authenticate_user, only: %i[doctor_register assistant_register]
  before_action :admin_authorization, only: %i[doctor_register assistant_register]
  before_action :master_authorization, only: %i[admin_register]

  def user_register
    response = check_category(params[:category], 1)

    response = base_create(params) unless response[:status] == :unauthorized

    response = create_patient(params) unless response[:flag].nil? && !response[:flag]

    send_welcome_email unless response[:flag].nil? && !response[:flag]
    render(json: response[:message], status: response[:status])
  end

  def doctor_register
    response = check_category(params[:category], 2)

    response = base_create(params) unless response[:status] == :unauthorized

    response = create_address(params) unless response[:flag].nil? && !response[:flag]

    response = create_doctor(params) unless response[:flag].nil? && !response[:flag]

    send_welcome_email unless response[:flag].nil? && !response[:flag]
    render(json: response[:message], status: response[:status])
  end

  def assistant_register
    response = check_category(params[:category], 3)

    response = base_create(params) unless response[:status] == :unauthorized

    response = create_address(params) unless response[:flag].nil? && !response[:flag]

    send_welcome_email unless response[:flag].nil? && !response[:flag]
    render(json: response[:message], status: response[:status])
  end

  def admin_register
    response = check_category(params[:category], 4)

    response = base_create(params) unless response[:status] == :unauthorized

    send_welcome_email unless response[:flag].nil? && !response[:flag]
    render(json: response[:message], status: response[:status])
  end

  def master_register
    response = check_category(params[:category], 5)

    response = base_create(params) unless response[:status] == :unauthorized

    send_welcome_email unless response[:flag].nil? && !response[:flag]
    render(json: response[:message], status: response[:status])
  end

  private

  def check_master_auth
    response = master_password

    { status: true } unless response

    { message: 'Master password is wrong', status: :unauthorized } if response
  end

  def check_category(category, flag)
    case flag
    when 1
      if  category != 'patient'
        { message: 'Only use this for patient', status: :unauthorized }
      else
        { status: true }
      end
    when 2
      if  category != 'doctor'
        { message: 'Only use this for doctor', status: :unauthorized }
      else
        { status: true }
      end
    when 3
      if  category != 'assistant'
        { message: 'Only use this for assistant', status: :unauthorized }
      else
        { status: true }
      end
    when 4
      if  category != 'admin'
        { message: 'Only use this for admin', status: :unauthorized }
      else
        { status: true }
      end
    when 5
      if  category != 'master'
        { message: 'Only use this for master', status: :unauthorized }
      else
        check_master_auth
      end
    end
  end

  def send_welcome_email
    WelcomeMailer.with(email: @user.email, full_name: @people.full_name).send_email.deliver_later
  end

  def base_create(params)
    response = create_user(params[:email], params[:password])
    unless response[:flag]
      return { message: { user_error: @user.errors.full_messages }, status: response[:status] }
    end

    response = create_account(params[:category])
    unless response[:flag]
      return { message: { account_error: @account.errors.full_messages }, status: response[:status] }
    end

    response = create_people(
      params[:first_name],
      params[:last_name],
      params[:birthdate],
      params[:gender],
      params[:nationality_id]
    )
    unless response[:flag]
      return { message: { person_error: @people.errors.full_messages }, status: response[:status] }
    end

    response = create_language(params[:languages])
    unless response[:flag]
      return { message: { language_error: 'Not found' }, status: response[:status] }
    end

    response = create_document(params[:document_type], params[:document_number])
    unless response[:flag]
      return { message: { document_error: @document.errors.full_messages }, status: response[:status] }
    end

    response = create_phone(
      params[:country_code],
      params[:area_code],
      params[:phone_number]
    )
    unless response[:flag]
      return { message: { phone_error: @phone.errors.full_messages }, status: response[:status] }
    end

    { message: 'created',  status: CREATED, flag: true }
  end

  def create_patient(_params)
    @patient = Patient.new(
      person_id: @people.id,
      privacy_policy: true,
      terms_use: true,
      client_ip: request.remote_ip
    )
    begin
      @patient.save!

      { message: 'created', status: CREATED, flag: true }
    rescue ActiveRecord::RecordInvalid
      @user.delete
      @account.delete
      @people.delete
      @document.delete
      @documents_person.delete
      @languages_person.each(&:delete)

      { message: { patient_error: @patient.errors.full_messages }, status: NOT_CREATED }
    end
  end

  def create_doctor(params)
    @doctor = Doctor.new(
      person_id: @people.id,
      photo: 'foto.pdf',
      about: params[:about],
      status: 0
    )
    begin
      @doctor.save!

      { message: 'created', status: CREATED, flag: true }
    rescue ActiveRecord::RecordInvalid
      @user.delete
      @account.delete
      @people.delete
      @document.delete
      @documents_person.delete
      @languages_person.each(&:delete)
      @address.delete
      @address_person.delete

      { message: { doctor_error: @doctor.errors.full_messages }, status: NOT_CREATED }
    end
  end

  def create_address(params)
    @address = Address.new(
      street: params[:street],
      street_number: params[:street_number],
      zipcode: params[:zipcode],
      country: params[:country],
      city: params[:city],
      state: params[:state]
    )
    begin
      @address.save!

      create_relation_address
      { message: 'created', status: CREATED, flag: true }
    rescue ActiveRecord::RecordInvalid
      @user.delete
      @account.delete
      @people.delete
      @document.delete
      @documents_person.delete
      @languages_person.each(&:delete)

      { message: { address_error: @address.errors.full_messages }, status: NOT_CREATED }
    end
  end

  def create_relation_address
    @address_person = AddressesPerson.create(
      address_id: @address.id,
      person_id: @people.id
    )
  end

  def create_user(email, password)
    @user = User.new(email: email, password: password)
    begin
      @user.save!

      { flag: true }
    rescue ActiveRecord::RecordInvalid
      if User.exists?(email: email)
        { flag: false, status: ALREADY_CREATED }
      else
        { flag: false, status: NOT_CREATED }
      end
    end
  end

  def create_account(category)
    @account = Account.new(user_id: @user.id, category: category)
    begin
      @account.save!

      { flag: true }
    rescue ActiveRecord::RecordInvalid
      @user.delete

      { flag: false, status: NOT_CREATED }
    end
  end

  def create_people(_first_name, _last_name, _birthdate, _gender, _nationality_id)
    @people = People.new(
      account_id: @account.id,
      first_name: params[:first_name],
      last_name: params[:last_name],
      birthdate: params[:birthdate],
      gender: params[:gender],
      nationality_id: params[:nationality_id]
    )
    begin
      @people.save!

      { flag: true }
    rescue ActiveRecord::RecordInvalid
      @user.delete
      @account.delete

      { flag: false, status: NOT_CREATED }
    end
  end

  def create_language(languages)
    @languages_objects = []
    # Get all languages objects
    languages.each do |language|
      object = Language.find_by(id: language)
      if object.nil?
        @user.delete
        @people.delete
        @account.delete

        return { flag: false, status: NOT_FOUND }
      else
        @languages_objects << object
      end
    end
    # Create many-to-many realtion
    languages_person
  end

  def languages_person
    @languages_person = []
    @languages_objects.each do |language|
      @languages_person << LanguagesPerson.create(
        language_id: language.id,
        person_id: @people.id
      )
    end
    { flag: true }
  end

  def create_document(document_type, document_number)
    @document = Document.new(document_type: document_type, number: document_number)
    begin
      @document.save!
      @documents_person = DocumentsPerson.new(document_id: @document.id, person_id: @people.id)

      { flag: true }
    rescue ActiveRecord::RecordInvalid
      @user.delete
      @account.delete
      @people.delete
      @languages_person.each(&:delete)

      { flag: false, status: NOT_CREATED }
    end
  end

  def create_phone(_country_code, _area_code, _phone_number)
    @phone = Phone.new(
      country_code: params[:country_code],
      area_code: params[:area_code],
      number: params[:phone_number]
    )
    begin
      @phone.save!
      PeoplePhone.create(phone_id: @phone.id, person_id: @people.id)

      { flag: true }
    rescue ActiveRecord::RecordInvalid
      @user.delete
      @account.delete
      @people.delete
      @document.delete
      @documents_person.delete
      @languages_person.each(&:delete)

      { flag: false, status: NOT_CREATED }
    end
  end
end
