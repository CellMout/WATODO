Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check
  get "profile", to: "pages#profile"

  resources :requests, only: [ :show, :new, :create, :edit, :update ]

  resources :activities, only: [ :update ]
end
