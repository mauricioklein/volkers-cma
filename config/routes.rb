Rails.application.routes.draw do
  resources :users, only: :create
  namespace :users do
    post 'login', to: :login
    post 'logout', to: :logout
  end

  resources :contracts, only: [:show, :create, :destroy]
end
