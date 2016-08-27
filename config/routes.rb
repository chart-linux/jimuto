Rails.application.routes.draw do
  resources :windows
  resources :request_solutions
  resources :shifts
  devise_for :users

  root to: "home#index"
  resources :home, only: :index
end
