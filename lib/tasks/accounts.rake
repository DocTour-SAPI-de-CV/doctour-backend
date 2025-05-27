# frozen_string_literal: true

namespace :accounts do
  desc 'Populate default accounts'
  task setup: :environment do
    accounts = [
      { email: ENV['DOCTOR1_EMAIL'] || 'doutor@doctour.com',   
        password: ENV['DOCTOR1_PASSWORD'] || SecureRandom.alphanumeric(16),  
        first_name: ENV['DOCTOR1_FIRST_NAME'] || 'José',   
        last_name: ENV['DOCTOR1_LAST_NAME'] || 'Ricardo',  
        gender: 'male', category: 'doctor',  
        document_number: ENV['DOCTOR1_DOCUMENT'] || 'ROAA220101HBCDNN012' },  
  
      { email: ENV['DOCTOR2_EMAIL'] || 'doutor2@doctour.com',   
        password: ENV['DOCTOR2_PASSWORD'] || SecureRandom.alphanumeric(16),  
        first_name: ENV['DOCTOR2_FIRST_NAME'] || 'Carla',   
        last_name: ENV['DOCTOR2_LAST_NAME'] || 'Mendes',  
        gender: 'female', category: 'doctor',  
        document_number: ENV['DOCTOR2_DOCUMENT'] || 'ROAA220101HBCDNN013' },  
  
      { email: ENV['PATIENT1_EMAIL'] || 'paciente@doctour.com',   
        password: ENV['PATIENT1_PASSWORD'] || SecureRandom.alphanumeric(16),  
        first_name: ENV['PATIENT1_FIRST_NAME'] || 'Antonio',   
        last_name: ENV['PATIENT1_LAST_NAME'] || 'Rodrigo',  
        gender: 'male', category: 'patient',  
        document_number: ENV['PATIENT1_DOCUMENT'] || 'ROAA220101HBCDNN011' },  
  
      { email: ENV['PATIENT2_EMAIL'] || 'paciente2@doctour.com',   
        password: ENV['PATIENT2_PASSWORD'] || SecureRandom.alphanumeric(16),  
        first_name: ENV['PATIENT2_FIRST_NAME'] || 'Thaise',   
        last_name: ENV['PATIENT2_LAST_NAME'] || 'Gabriela',  
        gender: 'male', category: 'patient',  
        document_number: ENV['PATIENT2_DOCUMENT'] || 'ROAA220101HBCDNN046' },  
  
      { email: ENV['PATIENT3_EMAIL'] || 'paciente3@doctour.com',   
        password: ENV['PATIENT3_PASSWORD'] || SecureRandom.alphanumeric(16),  
        first_name: ENV['PATIENT3_FIRST_NAME'] || 'Diego',   
        last_name: ENV['PATIENT3_LAST_NAME'] || 'Eduardo',  
        gender: 'male', category: 'patient',  
        document_number: ENV['PATIENT3_DOCUMENT'] || 'ROAA220101HBCDNN044' },  
  
      { email: ENV['ASSISTANT1_EMAIL'] || 'assistente@doctour.com',   
        password: ENV['ASSISTANT1_PASSWORD'] || SecureRandom.alphanumeric(16),  
        first_name: ENV['ASSISTANT1_FIRST_NAME'] || 'Amanda',   
        last_name: ENV['ASSISTANT1_LAST_NAME'] || 'Santos',  
        gender: 'female', category: 'assistant',  
        document_number: ENV['ASSISTANT1_DOCUMENT'] || 'ROAA220101HBCDNN020' },  
  
      { email: ENV['ASSISTANT2_EMAIL'] || 'assistente2@doctour.com',   
        password: ENV['ASSISTANT2_PASSWORD'] || SecureRandom.alphanumeric(16),  
        first_name: ENV['ASSISTANT2_FIRST_NAME'] || 'Fátima',   
        last_name: ENV['ASSISTANT2_LAST_NAME'] || 'Silva',  
        gender: 'female', category: 'assistant',  
        document_number: ENV['ASSISTANT2_DOCUMENT'] || 'ROAA220101HBCDNN014' },  
  
      { email: ENV['ASSISTANT3_EMAIL'] || 'assistente3@doctour.com',   
        password: ENV['ASSISTANT3_PASSWORD'] || SecureRandom.alphanumeric(16),  
        first_name: ENV['ASSISTANT3_FIRST_NAME'] || 'Junior',   
        last_name: ENV['ASSISTANT3_LAST_NAME'] || 'Carvalho',  
        gender: 'male', category: 'assistant',  
        document_number: ENV['ASSISTANT3_DOCUMENT'] || 'ROAA220101HBCDNN015' },  
  
      { email: ENV['ADMIN_EMAIL'] || 'admin@doctour.com',   
        password: ENV['ADMIN_PASSWORD'] || SecureRandom.alphanumeric(16),  
        first_name: ENV['ADMIN_FIRST_NAME'] || 'Andressa',   
        last_name: ENV['ADMIN_LAST_NAME'] || 'Souza',  
        gender: 'female', category: 'admin',  
        document_number: ENV['ADMIN_DOCUMENT'] || 'ROAA220101HBCDNN016' },  
  
      { email: ENV['DOCTOR_GLOYO_EMAIL'] || 'gloyo@doctour.com.mx',   
        password: ENV['DOCTOR_GLOYO_PASSWORD'] || SecureRandom.alphanumeric(16),  
        first_name: ENV['DOCTOR_GLOYO_FIRST_NAME'] || 'Guillermo',   
        last_name: ENV['DOCTOR_GLOYO_LAST_NAME'] || 'Loyo',  
        gender: 'male', category: 'doctor',  
        document_number: ENV['DOCTOR_GLOYO_DOCUMENT'] || 'ROAA220101HBCDNN017' },  
  
      { email: ENV['DOCTOR_PATRICIA_EMAIL'] || 'cachoytap@gmail.com',   
        password: ENV['DOCTOR_PATRICIA_PASSWORD'] || SecureRandom.alphanumeric(16),  
        first_name: ENV['DOCTOR_PATRICIA_FIRST_NAME'] || 'Patricia',   
        last_name: ENV['DOCTOR_PATRICIA_LAST_NAME'] || 'Arreguín',  
        gender: 'female', category: 'doctor',  
        document_number: ENV['DOCTOR_PATRICIA_DOCUMENT'] || 'CAAP830430MDFCRTOO' },  
  
      { email: ENV['DOCTOR_ANA_EMAIL'] || 'info@holanutricion.com',   
        password: ENV['DOCTOR_ANA_PASSWORD'] || SecureRandom.alphanumeric(16),  
        first_name: ENV['DOCTOR_ANA_FIRST_NAME'] || 'Ana Ivette',   
        last_name: ENV['DOCTOR_ANA_LAST_NAME'] || 'Tamayo',  
        gender: 'female', category: 'doctor',  
        document_number: ENV['DOCTOR_ANA_DOCUMENT'] || '5615152' }
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
        birthdate: ENV['DEFAULT_BIRTHDATE'] || Date.current - 30.years,
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
        country_code: ENV['DEFAULT_COUNTRY_CODE'] || '55',
        area_code: ENV['DEFAULT_AREA_CODE'] || '51',
        number: ENV['DEFAULT_PHONE'] || '000000000'
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
          photo: ENV['DEFAULT_PHOTO'] || 'foto.png',
          status: 0
        )
      end

      if account[:category] == 'doctor'
        @doctor = Doctor.create(
          person_id: @person.id,
          photo: ENV['DEFAULT_PHOTO'] || 'foto.png',
          about: 'Médico de DocTour',
          status: 0
        )

        @specialization_doctor = DoctorsSpecialization.create(
          specialization_id: ENV['DEFAULT_DOCTOR_SPECIALIZATION_ID'] || 'Médico',
          doctor_id: @doctor.id
        )
      end

      next unless account[:category] == 'patient'

      @patient = Patient.create(
        person_id: @person.id,
        photo: ENV['DEFAULT_PHOTO'] || 'foto.png',
        privacy_policy: true,
        terms_use: true,
        client_ip: ENV['SETUP_CLIENT_IP'] || 'SYSTEM_SETUP'
      )

      Screening.create(
        performed_at: DateTime.now.utc,
        return: true,
        # doctor: @doctor,
        patient: @patient,
        reason_consultation: 'Dolor',
        temperature: '36',
        heart_rate: '93',
        respiratory_frequency: '5/9',
        weight: '88.4',
        height: '176',
        bmi: '1'
      )

      PathologicalsHistoric.create(
        patient: @patient,
        hypertension: true,
        diabetes: true,
        respiratory_disease: true,
        respiratory_disease_text: 'Respiratory disease',
        allergy: true,
        allergy_text: 'Allergy text',
        surgical_historic: false,
        surgical_historic_text: '',
        medicine: false,
        medicine_text: ''
      )

      NonPathologicalsHistoric.create(
        patient: @patient,
        alcoholic_beverages: true,
        drugs: true,
        drugs_name: 'Alcohol',
        tobacco_wallets: 2,
        vaccines: false,
        vaccines_name: '',
      )

      FamilyHistoric.create(
        patient: @patient,
        history_family_illnesses: true,
        side_family: 'both_sides',
        mother_side: 'Mother side',
        father_side: 'Father side'
      )

      GynecologicalObstetricHistoric.create(
        patient: @patient,
        last_menstrual_cycle: DateTime.now.utc,
        pregnancy: true,
        number_pregnancies: 1,
        normal_deliveries: 1,
        cesarean_deliveries: 0,
        abortion: 0,
        contraceptive_methods: true
      )

    end
  end
end
