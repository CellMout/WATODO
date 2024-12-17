Rails.application.routes.draw do
  devise_for :users
  root to: "requests#new"
  get "up" => "rails/health#show", as: :rails_health_check
  get "/profile", to: "pages#profile"

  resources :requests, only: [ :show, :new, :create, :edit, :update ] do
  member do
    patch :archive
  end
end
  resources :activities, only: [ :update ]
end
