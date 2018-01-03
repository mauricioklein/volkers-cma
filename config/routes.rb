Rails.application.routes.draw do
  resources :users, only: :create
  namespace :users do
    get 'login', to: :login
    get 'logout', to: :logout
  end

  resources :contracts, only: [:show, :create, :destroy]
end
