Rails.application.routes.draw do
  resources :shifts
  devise_for :users

  root to: "home#index"
  resources :home, only: :index
  resources :requests
  resources :solutions
end
