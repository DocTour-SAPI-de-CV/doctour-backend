# frozen_string_literal: true

namespace :accounts do
  desc 'Populate default accounts'
  task setup: :environment do
    accounts = [
      { email: 'doutor@doctour.com', password: 'doutor123',
        first_name: 'José', last_name: 'Ricardo',
        gender: 'male', category: 'doctor',
        document_number: 'ROAA220101HBCDNN012' },

      { email: 'doutor2@doctour.com', password: 'doutor123',
        first_name: 'Carla', last_name: 'Mendes',
        gender: 'female', category: 'doctor',
        document_number: 'ROAA220101HBCDNN013' },

      { email: 'paciente@doctour.com', password: 'paciente123',
        first_name: 'Antonio', last_name: 'Rodrigo',
        gender: 'male', category: 'patient',
        document_number: 'ROAA220101HBCDNN011' },

      { email: 'paciente2@doctour.com', password: 'paciente123',
        first_name: 'Thaise', last_name: 'Gabriela',
        gender: 'male', category: 'patient',
        document_number: 'ROAA220101HBCDNN046' },

      { email: 'paciente3@doctour.com', password: 'paciente123',
        first_name: 'Diego', last_name: 'Eduardo',
        gender: 'male', category: 'patient',
        document_number: 'ROAA220101HBCDNN044' },

      { email: 'assistente@doctour.com', password: 'assistente123',
        first_name: 'Amanda', last_name: 'Santos',
        gender: 'female', category: 'assistant',
        document_number: 'ROAA220101HBCDNN013' },

      { email: 'assistente2@doctour.com', password: 'assistente123',
        first_name: 'Fátima', last_name: 'Silva',
        gender: 'female', category: 'assistant',
        document_number: 'ROAA220101HBCDNN014' },

      { email: 'assistente3@doctour.com', password: 'assistente123',
        first_name: 'Junior', last_name: 'Carvalho',
        gender: 'male', category: 'assistant',
        document_number: 'ROAA220101HBCDNN015' },

      { email: 'admin@doctour.com', password: 'admin123',
        first_name: 'Andressa', last_name: 'Souza',
        gender: 'female', category: 'admin',
        document_number: 'ROAA220101HBCDNN016' }
    ]

    accounts.each do |account|
      object = User.where(email: account[:email])

      next if object.present?

      @user = User.create(
        email: account[:email],
        password: account[:password]
      )

      @account = Account.create(user_id: @user.id, category: account[:category])

      @person = People.create(
        account_id: @account.id,
        first_name: account[:first_name],
        last_name: account[:last_name],
        birthdate: '1975-07-11',
        gender: account[:gender],
        nationality_id: Nationality.first.id
      )

      @document = Document.create(
        document_type: 'CURP',
        number: account[:document_number]
      )

      @document_person = DocumentsPerson.create(
        document_id: @document.id,
        person_id: @person.id
      )

      @phone = Phone.create(
        country_code: '55',
        area_code: '51',
        number: '985868852'
      )

      @person_phone = PeoplePhone.create(
        phone_id: @phone.id,
        person_id: @person.id
      )

      @language_person = LanguagesPerson.create(
        language_id: Language.first.id,
        person_id: @person.id,
        native: true
      )

      if account[:category] == 'assistant' || account[:category] == 'doctor'
        @address = Address.create(
          street: 'Rua Santos Drumond',
          street_number: '99',
          zipcode: '98996999',
          country: 'Brazil',
          city: 'Antonieta',
          state: 'RS'
        )

        @address_person = AddressesPerson.create(
          address_id: @address.id,
          person_id: @person.id
        )
      end

      if account[:category] == 'assistant'
        @assistant = Assistant.create(
          person_id: @person.id,
          photo: 'foto.png',
          status: 0
        )
      end

      if account[:category] == 'doctor'
        @doctor = Doctor.create(
          person_id: @person.id,
          photo: 'foto.png',
          about: 'Doctor of DocTour',
          status: 0
        )

        @specialization_doctor = DoctorsSpecialization.create(
          specialization_id: Specialization.first.id,
          doctor_id: @doctor.id
        )
      end

      next unless account[:category] == 'patient'

      @patient = Patient.create(
        person_id: @person.id,
        privacy_polity: true,
        terms_use: true,
        client_ip: '192.168.1.1'
      )

      Screening.create(
        performed_at: DateTime.new(2020, 0o5, 31, 14, 31).utc,
        return: true,
        doctor: @doctor,
        patient: @patient,
        temperature: '36',
        heart_rate: '93',
        blood_pressure: '5/9',
        weight: '88.4',
        height: '176'
      )
    end
  end
end
