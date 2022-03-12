# frozen_string_literal: true

namespace :populate do
  desc "Populate nationality, languages and medical especializations"
  task setup: :environment do
    nationalities =
      ["Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Antigua and Barbuda",
       "Argentina", "Armenia", "Australia", "Austria", "Azerbaijan",
       "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium",
       "Belize", "Benin", "Bhutan", "Bolivia", "Bosnia and Herzegovina", "Botswana",
       "Brazil", "Brunei", "Bulgaria", "Burkina Faso", "Burundi", "Côte d'Ivoire",
       "Cabo Verde", "Cambodia", "Cameroon", "Canada", "Central African Republic", "Chad",
       "Chile", "China", "Colombia", "Comoros", "Congo (Congo-Brazzaville)", "Costa Rica",
       "Croatia", "Cuba", "Cyprus", "Czechia (Czech Republic)", "Democratic Republic of the Congo",
       "Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt", "El Salvador",
       "Equatorial Guinea", "Eritrea", "Estonia", "Eswatini (fmr. 'Swaziland')", "Ethiopia", "Fiji", "Finland",
       "France", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Greece", "Grenada",
       "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Holy See", "Honduras",
       "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Israel",
       "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Kuwait", "Kyrgyzstan",
       "Laos", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg",
       "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall", "Islands",
       "Mauritania", "Mauritius", "Mexico", "Micronesia", "Moldova", "Monaco", "Mongolia",
       "Montenegro", "Morocco", "Mozambique", "Myanmar (formerly Burma)", "Namibia", "Nauru", "Nepal",
       "Netherlands", "New Zealand", "Nicaragua", "Niger", "Nigeria", "North Korea", "North Macedonia",
       "Norway", "Oman", "Pakistan", "Palau", "Palestine State", "Panama", "Papua New Guinea",
       "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Qatar", "Romania", "Russia",
       "Rwanda", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines",
       "Samoa", "San Marino", "Sao Tome and Principe", "Saudi", "Arabia", "Senegal", "Serbia", "Seychelles",
       "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon", "Islands", "Somalia",
       "South Africa", "South Korea", "South Sudan", "Spain", "Sri Lanka" "Sudan", "Suriname",
       "Sweden", "Switzerland", "Syria", "Tajikistan", "Tanzania", "Thailand", "Timor-Leste", "Togo",
       "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Tuvalu", "Uganda",
       "Ukraine", "United Arab Emirates", "United Kingdom", "United States of America", "Uruguay", "Uzbekistan",
       "Vanuatu", "Venezuela", "Vietnam", "Yemen", "Zambia", "Zimbabwe"]

    insert_nationalities = []

    nationalities.each do |nationality|
      insert_nationalities << {
        name: nationality.downcase,
        created_at: DateTime.now,
        updated_at: DateTime.now,
      }
    end

    Nationality.insert_all(insert_nationalities)

    #######

    languages = [
      "spanish", "english", "chinese mandarim",
      "hindi", "french", "arabic", "bengali",
      "russian", "portuguese", "indonesian",
    ]

    insert_languages = []

    languages.each do |language|
      insert_languages << {
        name: language.downcase,
        created_at: DateTime.now,
        updated_at: DateTime.now,
      }
    end

    Language.insert_all(insert_languages)

    #######

    plans = [
      { description: 'Plano 1' },
      { description: 'Plano 2' }
    ]

    insert_plans = []

    plans.each do |plan|
      insert_plans << {
        description: plans,
        created_at: DateTime.now,
        updated_at: DateTime.now,
      }
    end

    Plan.insert_all(insert_plans)

    #######

    services = [
      { name: 'Serviço 1', price: 10.5, description: 'Descrição serviço 1' },
      { name: 'Serviço 2', price: 50.5, description: 'Descrição serviço 2' },
    ]

    insert_services = []

    services.each do |service|
      puts service.to_json
      insert_services << {
        name: service[:name],
        price: service[:price],
        description: service[:description],
        created_at: DateTime.now,
        updated_at: DateTime.now,
      }
    end

    Service.insert_all(insert_services)

    #######

    plan_to_services = [
      { quantity: 1 }
    ]

    insert_plan_to_service = []

    plan_to_services.each do |plan_to_service|
      insert_plan_to_service << {
        quantity: plan_to_service[:quantity],
        plan_id: 1,
        service_id: 1,
        created_at: DateTime.now,
        updated_at: DateTime.now,
      }
    end

    PlanToService.insert_all(insert_plan_to_service)

    #######

    specializations = [
      "Medicina General", "Pediatría", "Geriatría",
      "Nutrición", "Psicología", "Medicina tropical",
    ]

    insert_specializations = []

    specializations.each do |specialization|
      insert_specializations << {
        name: specialization.downcase,
        created_at: DateTime.now,
        updated_at: DateTime.now,
      }
    end

    Specialization.insert_all(insert_specializations)

    attachments_types = [
      { name: "Reporte de consulta", create: Array["doctor", "assistant"], read: Array["doctor", "assistant", "patient"] },
      { name: "Fatura de Reembolso", create: Array["doctor", "assistant"], read: Array["doctor", "assistant", "patient"] },
      { name: "Receta Medica", create: Array["doctor", "assistant"], read: Array["doctor", "assistant", "patient"] },
      { name: "Pedido de Laboratorio/Examenes", create: Array["doctor", "assistant"], read: Array["doctor", "assistant", "patient"] },
      { name: "Reporte de procedimentos", create: Array["doctor", "assistant"], read: Array["doctor", "assistant"] },
      { name: "Reporte de efermaria", create: Array["doctor", "assistant"], read: Array["doctor", "assistant"] },
      { name: "Consentimiento informado", create: Array["doctor", "assistant"], read: Array["doctor", "assistant", "patient"] },
      { name: "Resultados de Laboratorio/Examenes", create: Array["doctor", "assistant", "patient"], read: Array["doctor", "assistant", "patient"] },
      { name: "Others", create: Array["doctor", "assistant", "patient"], read: Array["doctor", "assistant", "patient"] },
    ]

    insert_attachments_types = []

    attachments_types.each do |attachment_type|
      insert_attachments_types << {
        name: attachment_type[:name],
        create: attachment_type[:create],
        read: attachment_type[:read],
        created_at: DateTime.now,
        updated_at: DateTime.now,
      }
    end

    AttachmentType.insert_all(insert_attachments_types)
  end

  desc "Create chat messages"
  task create_chatmessages: :environment do
    doc = User.where(email: "doutor@doctour.com").first
    pat1 = User.where(email: "paciente2@doctour.com").first
    pat2 = User.where(email: "paciente3@doctour.com").first
    ChatMessage.create!(from: doc, to: pat1, message: "Olá, paciente!")
    ChatMessage.create!(from: pat1, to: doc, message: "Olá, doutor!")
    ChatMessage.create!(from: doc, to: pat1, message: "Tudo bem com você?")
    ChatMessage.create!(from: pat1, to: doc, message: "Estou melhor!")

    ChatMessage.create!(from: doc, to: pat2, message: "Olá, paciente!")
    ChatMessage.create!(from: pat2, to: doc, message: "Olá, doutor!")
    ChatMessage.create!(from: doc, to: pat2, message: "Tudo bem com você?")
    ChatMessage.create!(from: pat2, to: doc, message: "Ainda nao melhorei.")
  end
end
