# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize, Lint/MissingCopEnableDirective
class UnificationController < ApplicationController
  skip_before_action :authenticate_user
  respond_to :json

  def user_register
    # Create User
    user = User.new(email: params[:email], password: params[:password])
    if user.valid?
      user.save!
    else

      render(json: { user_error: user.errors })
      return
    end

    # Create Account
    account = Account.new(user_id: user.id, category: params[:category])
    if account.valid?
      account.save!
    else
      user.delete

      render(json: { account_error: account.errors })
      return
    end

    # Create People
    people = People.new(
      account_id: account.id,
      first_name: params[:first_name],
      last_name: params[:last_name],
      birthdate: params[:birthdate],
      gender: params[:gender]
    )
    if people.valid?
      people.save!
    else
      user.delete
      account.delete

      render(json: { account_error: account.errors })
      return
    end

    # Create Language
    language = Language.find_by(name: params[:language])
    if !language.nil?
      languages_person = LanguagesPerson.create(language_id: language.id, person_id: people.id)
    else
      user.delete
      account.delete

      render(json: { language_erro: 'not found on database' })
      return
    end

    # Document
    document = Document.new(document_type: params[:document_type], number: params[:document_number])
    if document.valid?
      document.save!
      documents_person = DocumentsPerson.create(person_id: people.id, document_id: document.id)
    else
      user.delete
      account.delete
      languages_person.delete

      render(json: { document_error: document.errors })
      return
    end

    # Phone
    phone = Phone.new(
      country_code: params[:country_code],
      area_code: params[:area_code],
      number: params[:phone_number]
    )

    if phone.valid?
      phone.save!
      PeoplePhone.create(phone_id: phone.id, person_id: people.id)
    else
      user.delete
      account.delete
      languages_person.delete
      documents_person.delete

      render(json: { phone_error: phone.errors })
      return
    end

    WelcomeMailer.with(email: user.email, full_name: people.full_name).send_email.deliver_later
    render json: 'user created!'
  end
end
