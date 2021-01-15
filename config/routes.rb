# frozen_string_literal: true

Rails.application.routes.draw do
  #Routes for divese
  devise_for :users,
    path: '',
    path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
    },
    controllers: {
    sessions: 'sessions',
    registrations: 'registrations'
    }
    
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'landing#index'
  post 'password_recovery', to:'password_recovery#index'
  patch 'password_recovery', to:'password_recovery#recovery'

  post 'patient_register', to:'register/patient#create'
  post 'doctor_register', to:'register/doctor#create'
  post 'assistant_register', to:'register/assistant#create'
  post 'admin_register', to:'register/admin#create'
  post 'master_register', to:'register/master#create'
  post 'attachment_register', to:'register/attachment#create'

  get 'show_account/:id', to:'register/show#account'


  # authenticate
  get 'user', to: 'application#user'

  # unification
  # post 'user_register', to: 'unification#user_register'
  # post 'doctor_register', to: 'unification#doctor_register'
  # post 'assistant_register', to: 'unification#assistant_register'
  # post 'admin_register', to: 'unification#admin_register'
  # post 'master_register', to: 'unification#master_register'

  # Attachment Type
  get 'attachment_types', to: 'attachment_type#show'

  # Filter
  get 'patient_filter/:id', to: 'filter#patient'
  get 'patient_name_filter/:name', to: 'filter#patient_name'
  get 'diagnostic_filter', to: 'filter#diagnostic'
  get 'doctors_status', to: 'filter#doctors_status'
  get 'doctor_report/:start_date'+'&'+':end_date', to: 'filter#doctor_report'

  # Assistant
  post 'assistant', to: 'assistant#create'
  put 'assistant/:id', to: 'assistant#update'
  get 'assistant', to: 'assistant#show'
  get 'assistant/:id', to: 'assistant#index'
  delete 'assistant/:id', to: 'assistant#delete'

  # Services
  post 'service', to: 'service#create'
  put 'service/:id', to: 'service#update'
  get 'service', to: 'service#show'
  get 'service/:id', to: 'service#index'
  delete 'service/:id', to: 'service#delete'

  #Routes for Account
  post 'account', to: 'account#create'
  put 'account/:id', to: 'account#update'
  get 'account', to: 'account#show'
  get 'account/:id', to: 'account#index'
  delete 'account/:id', to: 'account#delete'

  #Routes for People
  post 'people', to: 'people#create'
  put 'people/:id', to: 'people#update'
  get 'people', to: 'people#show'
  get 'people/:id', to: 'people#index'
  delete 'people/:id', to: 'people#delete'
  
  # Soaps
  post 'soap', to: 'soap#create'
  put 'soap/:id', to: 'soap#update'
  get 'soap', to: 'soap#show'
  get 'soap/:id', to: 'soap#index'
  delete 'soap/:id', to: 'soap#delete'

  get 'dashboard', to: 'dashboard#show'

  get 'dashboard_doctor/:id', to: 'dashboard_doctor#show'

  get 'dashboard_assistant', to: 'dashboard_assistant#show'

  # Subjectives
  post 'subjective', to: 'subjective#create'
  put 'subjective/:id', to: 'subjective#update'
  get 'subjective', to: 'subjective#show'
  get 'subjective/:id', to: 'subjective#index'
  delete 'subjective/:id', to: 'subjective#delete'

  # Objectives
  post 'objective', to: 'objective#create'
  put 'objective/:id', to: 'objective#update'
  get 'objective', to: 'objective#show'
  get 'objective/:id', to: 'objective#index'
  delete 'objective/:id', to: 'objective#delete'

  # Patient
  post 'patient', to: 'patient#create'
  put 'patient/:id', to: 'patient#update'
  get 'patient', to: 'patient#show'
  get 'patient/:id', to: 'patient#index'
  delete 'patient/:id', to: 'patient#delete'

  # Specializations
  post 'specialization', to: 'specialization#create'
  put 'specialization/:id', to: 'specialization#update'
  get 'specialization', to: 'specialization#show'
  get 'specialization/:id', to: 'specialization#index'
  delete 'specialization/:id', to: 'specialization#delete'

  # Doctors
  post 'doctor', to: 'doctor#create'
  put 'doctor/:id', to: 'doctor#update'
  get 'doctor', to: 'doctor#show'
  get 'doctor/:id', to: 'doctor#index'
  delete 'doctor/:id', to: 'doctor#delete'

  # Doctors specializations
  post 'doctor_specialization', to: 'doctors_specialization#create'
  put 'doctor_specialization/:id', to: 'doctors_specialization#update'
  get 'doctor_specialization', to: 'doctors_specialization#show'
  get 'doctor_specialization/:id', to: 'doctors_specialization#index'
  delete 'doctor_specialization/:id', to: 'doctors_specialization#delete'

  # Objectives soaps
  post 'objective_soap', to: 'objectives_soap#create'
  put 'objective_soap/:id', to: 'objectives_soap#update'
  get 'objective_soap', to: 'objectives_soap#show'
  get 'objective_soap/:id', to: 'objectives_soap#index'
  delete 'objective_soap/:id', to: 'objectives_soap#delete'

  # Subjectives soaps
  post 'subjective_soap', to: 'subjectives_soap#create'
  put 'subjective_soap/:id', to: 'subjectives_soap#update'
  get 'subjective_soap', to: 'subjectives_soap#show'
  get 'subjective_soap/:id', to: 'subjectives_soap#index'
  delete 'subjective_soap/:id', to: 'subjectives_soap#delete'

  # Phones
  post 'phone', to: 'phone#create'
  put 'phone/:id', to: 'phone#update'
  get 'phone', to: 'phone#show'
  get 'phone/:id', to: 'phone#index'
  delete 'phone/:id', to: 'phone#delete'

  # People phones
  post 'people_phone', to: 'people_phone#create'
  put 'people_phone/:id', to: 'people_phone#update'
  get 'people_phone', to: 'people_phone#show'
  get 'people_phone/:id', to: 'people_phone#index'
  delete 'people_phone/:id', to: 'people_phone#delete'

  # language people
  post 'languages_person', to: 'languages_person#create'
  put 'languages_person/:id', to: 'languages_person#update'
  get 'languages_person', to: 'languages_person#show'
  get 'languages_person/:id', to: 'languages_person#index'
  delete 'languages_person/:id', to: 'languages_person#delete'

  # Addresses
  post 'address', to: 'address#create'
  put 'address/:id', to: 'address#update'
  get 'address', to: 'address#show'
  get 'address/:id', to: 'address#index'
  delete 'address/:id', to: 'address#delete'

  # Addresses Person
  post 'address_person', to: 'addresses_person#create'
  put 'address_person/:id', to: 'addresses_person#update'
  get 'address_person', to: 'addresses_person#show'
  get 'address_person/:id', to: 'addresses_person#index'
  delete 'address_person/:id', to: 'addresses_person#delete'

  # Diagnostic
  post 'diagnostic_import', to: 'diagnostic_import#index'
  
  put 'diagnostic/:id', to: 'diagnostic#update'
  get 'diagnostic', to: 'diagnostic#show'
  get 'diagnostic/:id', to: 'diagnostic#index'
  post 'diagnostic', to: 'diagnostic#create'
  delete 'diagnostic/:id', to: 'diagnostic#delete'

  # Screenings
  post 'screening', to: 'screening#create'
  put 'screening/:id', to: 'screening#update'
  get 'screening', to: 'screening#show'
  get 'screening/:id', to: 'screening#index'
  delete 'screening/:id', to: 'screening#delete'

  # disagnostics soap
  post 'diagnostics_soap', to: 'diagnostics_soap#create'
  put 'diagnostics_soap/:id', to: 'diagnostics_soap#update'
  get 'diagnostics_soap', to: 'diagnostics_soap#show'
  get 'diagnostics_soap/:id', to: 'diagnostics_soap#index'
  delete 'diagnostics_soap/:id', to: 'diagnostics_soap#delete'

  # Language
  put 'language/:id', to: 'language#update'
  get 'language', to: 'language#show'
  get 'language/:id', to: 'language#index'
  post 'language', to: 'language#create'
  delete 'language/:id', to: 'language#delete'

  # Nationality
  put 'nationality/:id', to: 'nationality#update'
  get 'nationality', to: 'nationality#show'
  get 'nationality/:id', to: 'nationality#index'
  post 'nationality', to: 'nationality#create'
  delete 'nationality/:id', to: 'nationality#delete'

  # Partners
  post 'partner', to: 'partner#create'
  put 'partner/:id', to: 'partner#update'
  get 'partner', to: 'partner#show'
  get 'partner/:id', to: 'partner#index'
  delete 'partner/:id', to: 'partner#delete'

  # Partners Phone
  post 'partner_phone', to: 'partners_phone#create'
  put 'partner_phone/:id', to: 'partners_phone#update'
  get 'partner_phone', to: 'partners_phone#show'
  get 'partner_phone/:id', to: 'partners_phone#index'
  delete 'partner_phone/:id', to: 'partners_phone#delete'

  # Addresses Partner
  post 'address_partner', to: 'addresses_partner#create'
  put 'address_partner/:id', to: 'addresses_partner#update'
  get 'address_partner', to: 'addresses_partner#show'
  get 'address_partner/:id', to: 'addresses_partner#index'
  delete 'address_partner/:id', to: 'addresses_partner#delete'

  # Documents
  post 'document', to: 'document#create'
  put 'document/:id', to: 'document#update'
  get 'document', to: 'document#show'
  get 'document/:id', to: 'document#index'
  delete 'document/:id', to: 'document#delete'

  # Documents people
  post 'document_person', to: 'documents_person#create'
  put 'document_person/:id', to: 'documents_person#update'
  get 'document_person', to: 'documents_person#show'
  get 'document_person/:id', to: 'documents_person#index'
  delete 'document_person/:id', to: 'documents_person#delete'

  # Documents partners
  post 'document_partner', to: 'documents_partner#create'
  put 'document_partner/:id', to: 'documents_partner#update'
  get 'document_partner', to: 'documents_partner#show'
  get 'document_partner/:id', to: 'documents_partner#index'
  delete 'document_partner/:id', to: 'documents_partner#delete'

  # interprets
  post 'interpret', to: 'interpret#create'
  put 'interpret/:id', to: 'interpret#update'
  get 'interpret', to: 'interpret#show'
  get 'interpret/:id', to: 'interpret#index'
  delete 'interpret/:id', to: 'interpret#delete'

  # languages interprets
  post 'languages_interpret', to: 'languages_interpret#create'
  put 'languages_interpret/:id', to: 'languages_interpret#update'
  get 'languages_interpret', to: 'languages_interpret#show'
  get 'languages_interpret/:id', to: 'languages_interpret#index'
  delete 'languages_interpret/:id', to: 'languages_interpret#delete'

  # phones interprets
  post 'phones_interpret', to: 'phones_interpret#create'
  put 'phones_interpret/:id', to: 'phones_interpret#update'
  get 'phones_interpret', to: 'phones_interpret#show'
  get 'phones_interpret/:id', to: 'phones_interpret#index'
  delete 'phones_interpret/:id', to: 'phones_interpret#delete'

  # addressess interprets
  post 'addressess_interpret', to: 'addressess_interpret#create'
  put 'addressess_interpret/:id', to: 'addressess_interpret#update'
  get 'addressess_interpret', to: 'addressess_interpret#show'
  get 'addressess_interpret/:id', to: 'addressess_interpret#index'
  delete 'addressess_interpret/:id', to: 'addressess_interpret#delete'
end
