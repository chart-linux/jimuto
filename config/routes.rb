Rails.application.routes.draw do
  devise_for :users

  root to: "home#index"
  resources :home, only: :index
  resources :requests
  resources :solutions
  resources :windows
end
