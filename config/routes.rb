# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # root 'landing#index'
  post 'service', to: 'service#create'
  put 'service/:id', to: 'service#update'
  get 'service', to: 'service#show'
  get 'service/:id', to: 'service#index'
  delete 'service/:id', to: 'service#delete'
end
