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

  # root 'landing#index'

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
end
